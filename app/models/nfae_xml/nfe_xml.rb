require 'builder'

class NfeXml
    
    attr_accessor :infNFe, :nfae

    def initialize(nfae)
        @infNFe = "Teste infNFe"
        @nfae = nfae
    end

    def to_xml(enviNFe)
        enviNFe.NFe do |nFe|
            @NFe = InfNfeXml.new(@nfae).to_xml(nFe)
        end
    end
    
end