require 'nokogiri'
require 'openssl'
require 'base64'

class AssinadorXml
    def initialize(pkcs12: nil)
        @pkcs12 = pkcs12
    end

    def assinar(nfe_xml)
        pkcs = @pkcs12 || CertificadoService.new.pkcs12
        private_key = OpenSSL::PKey::RSA.new(pkcs.key.to_pem)
        cert = OpenSSL::X509::Certificate.new(pkcs.certificate.to_pem)
        digest = OpenSSL::Digest::SHA1.new
        inf_nfe = nfe_xml.search("infNFe").first
        digest_value = Base64.strict_encode64(
            digest.digest(
                inf_nfe.canonicalize(Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0, nil, nil)
            )
        )
        certificate = Base64.strict_encode64(cert.to_der)

        signature_xml = Nokogiri::XML::Builder.new do |xml|
            xml.Signature(xmlns: 'http://www.w3.org/2000/09/xmldsig#') do
                xml.SignedInfo do
                    xml.CanonicalizationMethod(Algorithm: 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315')
                    xml.SignatureMethod(Algorithm: 'http://www.w3.org/2000/09/xmldsig#rsa-sha1')
                    xml.Reference(URI: "##{inf_nfe.attribute("Id")}") do
                        xml.Transforms do
                            xml.Transform(Algorithm: 'http://www.w3.org/2000/09/xmldsig#enveloped-signature')
                            xml.Transform(Algorithm: 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315')
                        end
                        xml.DigestMethod(Algorithm: 'http://www.w3.org/2000/09/xmldsig#sha1')
                        xml.DigestValue digest_value
                    end
                end
                xml.SignatureValue
                xml.KeyInfo do
                    xml.X509Data do
                        xml.X509Certificate
                    end
                end
            end
        end

        signature = Base64.strict_encode64(
            private_key.sign(
                digest,
                signature_xml.doc.search("SignedInfo").first.canonicalize(Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0, nil, nil)
            )
        )

        signature_xml.doc.search("SignatureValue").first.content = signature
        signature_xml.doc.search("X509Certificate").first.content = certificate.chomp

        nfe_xml.search("NFe").first.add_child(signature_xml.doc.root)
        nfe_xml
    end
end
