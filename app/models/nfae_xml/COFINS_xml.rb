class COFINSXml
    def initialize(nfae, nItem)
      cst = nfae.prods[nItem]
      @CST = cst.CST
      @nfae = nfae
      @nItem = nItem
    end

    def to_xml(parent)
      parent.COFINS do |cofin|
        COFINSNTXml.new.to_xml(cofin)
      end
    end
  end
  