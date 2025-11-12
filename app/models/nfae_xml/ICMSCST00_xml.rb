class ICMSCST00Xml
  def initialize(nfae, nItem)
    cst = nfae.prods[nItem]
    @CST = cst.CST
    @nfae = nfae
    @nItem = nItem
    @orig = "0"
    @modBC = "3"
    @vBC = gerar_vBC(nfae, cst)
    @pICMS = cst.pICMS
    @vICMS = gerar_vICMS(nfae, cst)
  end

  def gerar_vBC(nfae, cst)
    vProd = cst.vUnCom.to_i * cst.qCom.to_i
    vBC = vProd.to_i + cst.vFrete.to_i + cst.vSeg.to_i - cst.vDesc.to_i + cst.vOutro.to_i
    vBC
  end

  def gerar_vICMS(nfae, cst)
    vICMS = (@vBC.to_i * @pICMS.to_i) / 100
    vICMS
  end

  def to_xml(parent)
    parent.ICMS00 do |icms|
      icms.orig(@orig)
      icms.CST(@CST)
      icms.modBC(@modBC)
      icms.vBC(sprintf('%.2f', @vBC))
      icms.pICMS(@pICMS)
      icms.vICMS(@vICMS)
    end
  end
end
