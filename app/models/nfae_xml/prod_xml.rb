require 'builder'

class ProdXml
  attr_accessor :cProd, :xProd, :NCM, :CFOP, :uCom, :qCom, :vUnCom, :vProd, :cEANTrib, :vUnTrib, :vFrete, :vSeg, :vDesc, :vOutro, :CST, :pRedBC, :pICMS, :pICMSUFDest

  def initialize(nfae, nItem)
    prod = nfae.prods[nItem] 
  
    @cProd = prod.cProd
    @cEAN = "SEM GTIN"
    @xProd = prod.xProd
    @NCM = prod.NCM
    @CFOP = prod.CFOP
    @uCom = prod.uCom
    @qCom = prod.qCom
    @vUnCom = prod.vUnCom
    @vProd  = gerar_vProd(nfae, nItem)
    @cEANTrib = "SEM GTIN"
    @uTrib = prod.uTrib
    @qTrib = prod.qTrib
    @vUnTrib = prod.vUnCom
    @vFrete = prod.vFrete
    @vSeg = prod.vSeg
    @vDesc = prod.vDesc
    @vOutro = prod.vOutro
    @indTot = '1'
  end


  def gerar_vProd(nfae, nItem)
    prod = nfae.prods[nItem]
    vProd = prod.vUnCom.to_f * prod.qCom.to_f
    vProd
  end

  def to_xml(parent)
    parent.prod do |prod|
      prod.cProd(@cProd)
      prod.cEAN(@cEAN)
      prod.xProd(@xProd)
      prod.NCM(@NCM)
      prod.CFOP(@CFOP)
      prod.uCom(@uCom)
      prod.qCom(@qCom)
      prod.vUnCom(@vUnCom)
      prod.vProd(sprintf('%.2f', @vProd))
      prod.cEANTrib(@cEANTrib)
      prod.uTrib(@uTrib)
      prod.qTrib(@qTrib)
      prod.vUnTrib(@vUnTrib)
      prod.vFrete(@vFrete) if @vFrete.present?
      prod.vSeg(@vSeg) if @vSeg.present?
      prod.vDesc(@vDesc) if @vDesc.present?
      prod.vOutro(@vOutro) if @vOutro.present?
      prod.indTot(@indTot)
    end
  end
end
