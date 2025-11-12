class PagXml
  
    def initialize(nfae, infNfe)
      @nfae = nfae
      @infNfe = infNfe
      @vNF = infNfe.vNF
    end
  
    def to_xml(infNfe)
      infNfe.pag do |pag|
          DetPagXml.new(@nfae, self, @vNF).to_xml(pag)
      end
    end

end
  