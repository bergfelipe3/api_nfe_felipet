require 'base64'
require 'openssl'

class CertificadoService
    class CertificadoInvalidoError < StandardError; end

    def self.encrypt(value)
        return value if value.blank?
        encryptor.encrypt_and_sign(value)
    end

    def self.decrypt(value)
        return value if value.blank?
        encryptor.decrypt_and_verify(value)
    rescue ActiveSupport::MessageVerifier::InvalidSignature => e
        raise CertificadoInvalidoError, "Falha ao descriptografar o certificado: #{e.message}"
    end

    def initialize(certificado_id: nil, pfx_base64: nil, senha_certificado: nil)
        @certificado_id = certificado_id
        @pfx_base64 = pfx_base64
        @senha_certificado = senha_certificado
    end

    def pkcs12
        @pkcs12 ||= carregar_pkcs12
    end

    def chave_privada
        pkcs12.key
    end

    def certificado
        pkcs12.certificate
    end

    private

    def carregar_pkcs12
        if @certificado_id.present?
            carregar_do_banco
        elsif @pfx_base64.present? && @senha_certificado.present?
            construir_pkcs12(@pfx_base64, @senha_certificado)
        else
            certificado_legado
        end
    end

    def carregar_do_banco
        registro = Certificado.find(@certificado_id)
        pfx_b64 = CertificadoService.decrypt(registro.pfx_criptografado)
        senha = CertificadoService.decrypt(registro.senha_criptografada)
        construir_pkcs12(pfx_b64, senha)
    rescue ActiveRecord::RecordNotFound
        raise CertificadoInvalidoError, "Certificado não encontrado para o id informado."
    end

    def construir_pkcs12(pfx_base64, senha_certificado)
        raise CertificadoInvalidoError, "O conteúdo do certificado (pfx_base64) é obrigatório." if pfx_base64.blank?
        raise CertificadoInvalidoError, "A senha do certificado é obrigatória." if senha_certificado.blank?

        pkcs_bytes = Base64.strict_decode64(pfx_base64)
        OpenSSL::PKCS12.new(pkcs_bytes, senha_certificado)
    rescue ArgumentError, OpenSSL::PKCS12::PKCS12Error => e
        raise CertificadoInvalidoError, "Certificado ou senha inválidos. #{e.message}"
    end

    def self.encryptor
        secret = Rails.application.secret_key_base
        raise CertificadoInvalidoError, "SECRET_KEY_BASE não configurado." if secret.blank?

        key_length = ActiveSupport::MessageEncryptor.key_len
        key = ActiveSupport::KeyGenerator.new(secret).generate_key('certificado-service', key_length)
        ActiveSupport::MessageEncryptor.new(key)
    end
    private_class_method :encryptor
end
