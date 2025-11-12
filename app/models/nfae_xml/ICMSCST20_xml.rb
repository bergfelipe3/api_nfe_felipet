class ICMSCST20Xml
  def initialize(nfae, nItem)
    cst = nfae.prods[nItem]
    @CST = cst.CST
    @nfae = nfae
    @nItem = nItem
    @orig = "0"
    @modBC = "3"
    @pRedBC = cst.pRedBC
    @vBC = calcular_vBC_20(nfae, cst)
    @pICMS = cst.pICMS
    @vICMS = gerar_vICMS_20(nfae, cst)
  end

  def calcular_vBC_20(nfae, cst)
    vProd = cst.vUnCom.to_i * cst.qCom.to_i
    pRedBC = cst.pRedBC.to_i
    vBC = (vProd + cst.vFrete.to_i + cst.vSeg.to_i - cst.vDesc.to_i + cst.vOutro.to_i) * (1 - (pRedBC / 100))
    vBC
  end

  def gerar_vICMS_20(nfae, cst)
    vICMS = (@vBC.to_i * @pICMS.to_i) / 100
    vICMS
  end

  def to_xml(parent)
    parent.ICMS20 do |icms|
      icms.orig(@orig)
      icms.CST(@CST)
      icms.modBC(@modBC)
      icms.pRedBC(@pRedBC)
      icms.vBC(sprintf('%.2f', @vBC))
      icms.pICMS(@pICMS)
      icms.vICMS(@vICMS)
    end
  end
end
