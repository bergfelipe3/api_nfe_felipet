require 'net/http'
require 'json'
require 'uri'
require 'openssl'
require 'rexml/document'
require 'zlib'
require 'base64'

class Autorizador

    def initialize(pkcs12: nil)
        @pkcs12 = pkcs12
    end

    def autorizar(xml_assinado, tpAmb)
        @uri = definir_endpoint(tpAmb)

        pkcs = @pkcs12 || CertificadoService.new.pkcs12
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true
        @http.cert = pkcs.certificate
        @http.key = pkcs.key
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(@uri.request_uri)
        request.content_type = 'application/soap+xml'
        request.body = "<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:nfe=\"http://www.portalfiscal.inf.br/nfe/wsdl/NFeAutorizacao4\">
        <soap:Header/>
        <soap:Body>
           <nfe:nfeDadosMsg>
           #{xml_assinado}
           </nfe:nfeDadosMsg>
        </soap:Body>
        </soap:Envelope>"

        response = @http.request(request)
        xml_resposta = REXML::Document.new(response.body)
        protNFe = xml_resposta.elements['//protNFe']

        doc = Nokogiri::XML(xml_assinado)
        nfe_element = doc.at_xpath('//xmlns:NFe')
        nfe_element.add_next_sibling(protNFe.to_s)
        modified_xml = doc.to_xml

        {
            "versao": xml_resposta.elements['//retEnviNFe'].attributes['versao'],
            "tpAmb": xml_resposta.elements['//tpAmb'].text,
            "verAplic": xml_resposta.elements['//verAplic'].text,
            "cStat": xml_resposta.elements['//infProt/cStat']&.text || xml_resposta.elements['//cStat']&.text,
            "xMotivo": xml_resposta.elements['//infProt/xMotivo']&.text || xml_resposta.elements['//xMotivo']&.text,
            "cUF": xml_resposta.elements['//cUF'].text,
            "dhRecbto": xml_resposta.elements['//dhRecbto'].text,
            "chNFe": xml_resposta.elements['//chNFe']&.text || nil,
            "xmlAssinado": Base64.strict_encode64(modified_xml),
            "nProt": xml_resposta.elements['//infProt/nProt']&.text || nil,
            "digVal": xml_resposta.elements['//infProt/digVal']&.text || nil
        }
    end

    private

    def definir_endpoint(tpAmb)
        if tpAmb == 1
            URI.parse("https://nfe.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx")
        else
            URI.parse("https://nfe-homologacao.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx")
        end
    end
end
