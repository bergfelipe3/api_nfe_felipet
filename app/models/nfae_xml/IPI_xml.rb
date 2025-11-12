class IPIXml
    def initialize(nfae, nItem)
      cst = nfae.prods[nItem]
      @CST = cst.CST
      @nfae = nfae
      @nItem = nItem
      @cEnq = "999"
    end
  
    def to_xml(parent)
      parent.IPI do |ipi|
        ipi.cEnq(@cEnq)
        IPINTXml.new.to_xml(ipi)
      end
    end
  end
  