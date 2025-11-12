class PISXml
    def initialize(nfae, nItem)
      cst = nfae.prods[nItem]
      @CST = cst.CST
      @nfae = nfae
      @nItem = nItem
    end
  
    def to_xml(parent)
      parent.PIS do |pis|
        PISNTXml.new.to_xml(pis)
      end
    end
  end
  