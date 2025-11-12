class TranspXml
    attr_accessor :modFrete
  
    def initialize(nfae, infNfe)
      @nfae = nfae
      @infNfe = infNfe
      @modFrete = nfae.transp.modFrete
    end
  
    def to_xml(infNfe)
      infNfe.transp do |transp|
        transp.modFrete(@modFrete)
        unless @modFrete == "9"
          TransportaXml.new(@nfae, self).to_xml(transp)
          VolXml.new(@nfae, self).to_xml(transp)
        end
      end
    end
  end
  