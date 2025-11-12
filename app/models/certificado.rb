class Certificado < ApplicationRecord
  validates :nome, presence: true
  validates :pfx_criptografado, presence: true
  validates :senha_criptografada, presence: true

  def descriptografar_pfx
    CertificadoService.decrypt(pfx_criptografado)
  end

  def descriptografar_senha
    CertificadoService.decrypt(senha_criptografada)
  end
end
