require 'securerandom'

class Cssi


 
    def obterCSSI
        Rails.env.production? ? '60be52c32e114aba849016920e59a478' : '60be52c32e114aba849016920e59a477'
    end

    def gerarCssi
        uuid = SecureRandom.uuid.delete('-')
        cssi = [uuid].pack('H*')
        cssi.unpack1('H*')
    end

    def validarHashCssi(cssi, numero_gta, hashCSSI, nome_chave)
        unless gerarHashCssi(cssi, numero_gta) == hashCSSI
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor #{hashCSSI} da chave #{nome_chave} não é válido como especificado no Layout JSON."
        end
    end


    def gerarHashCssi(cssi, numero_gta)
        # Passo 1: Concatenar o CSSI com o número da GTA
        concatenacao = cssi + numero_gta
        # Passo 2: Aplicar o algoritmo SHA-1
        sha1_resultado = Digest::SHA1.digest(concatenacao)
        # Passo 3: Converter o resultado para Base64
        base64_resultado = Base64.strict_encode64(sha1_resultado)
        # Passo 4: Atribuir o valor ao campo "hashCSRT"
        return base64_resultado
    end

end