require 'builder'

class EnviNfeXml
    
    attr_accessor :versao, :xmlns, :idLote, :indSinc, :NFe, :nfae

    def initialize(nfae)
        @versao = "4.00"
        @xmlns = "http://www.portalfiscal.inf.br/nfe"
        @idLote = "1"
        @indSinc = "1"
        @nfae = nfae
    end

    def to_xml
        xml = Builder::XmlMarkup.new
        xml.enviNFe(versao: @versao, xmlns: @xmlns) do |enviNFe|
            enviNFe.idLote @idLote
            enviNFe.indSinc @indSinc
            @NFe = NfeXml.new(@nfae).to_xml(enviNFe)
        end
    end

end
