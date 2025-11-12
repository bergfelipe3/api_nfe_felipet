class ICMSCST40Xml
  def initialize(nfae, nItem)
    cst = nfae.prods[nItem]
    @CST = cst.CST
    @nfae = nfae
    @nItem = nItem
    @orig = "0"
  end

  def to_xml(parent)
    parent.ICMS40 do |icms|
      icms.orig(@orig)
      icms.CST(@CST)
    end
  end
end
