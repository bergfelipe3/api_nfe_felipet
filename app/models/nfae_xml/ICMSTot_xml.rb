require 'nokogiri'

class ICMSTotXml
  attr_accessor :vBC, :vICMS, :vICMSDeson, :vFCPUFDest, :vICMSUFDest, :vICMSUFRemet,
                :vFCP, :vBCST, :vST, :vFCPST, :vFCPSTRet, :vProd, :vFrete, :vSeg, 
                :vDesc, :vII, :vIPI, :vIPIDevol, :vPIS, :vCOFINS, :vOutro, :vNF

  def initialize(nfae, infNfe, det)
    @vBC = gerar_vBC_total(det)
    @vICMS = gerar_vICMS_total(det)
    @vICMSDeson = 0.00
    @vFCPUFDest = gerar_vFCPUFDest_total(det)
    @vICMSUFDest = gerar_vICMSUFDest_total(det)
    @vICMSUFRemet = gerar_vICMSUFRemet_total(det)
    @vFCP = 0.00
    @vBCST = 0.00
    @vST = 0.00
    @vFCPST = 0.00
    @vFCPSTRet = 0.00
    @vProd = gerar_vProd_total(det)
    @vFrete = gerar_vFrete_total(det)
    @vSeg = gerar_vSeg_total(det)
    @vDesc = gerar_vDesc_total(det)
    @vII = 0.00
    @vIPI = 0.00
    @vIPIDevol = 0.00
    @vPIS = 0.00
    @vCOFINS = 0.00
    @vOutro = gerar_vOutro_total(det)
    @vNF = calcular_vNF_total
    infNfe.vNF = @vNF
  end

  # Métodos de cálculo para valores dinâmicos
  def gerar_vBC_total(det)
    sum_field(det, '//nfe:det/nfe:imposto/nfe:ICMS/*/nfe:vBC')
  end

  def gerar_vICMS_total(det)
    sum_field(det, '//nfe:det/nfe:imposto/nfe:ICMS/*/nfe:vICMS')
  end

  def gerar_vFCPUFDest_total(det)
    sum_field(det, '//nfe:det/nfe:imposto/nfe:ICMS/*/nfe:vFCPUFDest')
  end

  def gerar_vICMSUFDest_total(det)
    sum_field(det, '//nfe:det/nfe:imposto/nfe:ICMS/*/nfe:vICMSUFDest')
  end

  def gerar_vICMSUFRemet_total(det)
    sum_field(det, '//nfe:det/nfe:imposto/nfe:ICMS/*/nfe:vICMSUFRemet')
  end

  def gerar_vProd_total(det)
    sum_field(det, '//nfe:det/nfe:prod/nfe:vProd')
  end

  def gerar_vFrete_total(det)
    sum_field(det, '//nfe:det/nfe:prod/nfe:vFrete')
  end

  def gerar_vSeg_total(det)
    sum_field(det, '//nfe:det/nfe:prod/nfe:vSeg')
  end

  def gerar_vDesc_total(det)
    sum_field(det, '//nfe:det/nfe:prod/nfe:vDesc')
  end

  def gerar_vOutro_total(det)
    sum_field(det, '//nfe:det/nfe:prod/nfe:vOutro')
  end

  def calcular_vNF_total
    (@vProd || 0) - (@vDesc || 0) - (@vICMSDeson || 0) + (@vST || 0) + (@vST || 0) + (@vFrete || 0) + (@vFrete || 0) + (@vSeg || 0) + (@vOutro || 0) 
  end

  # Método genérico para somar valores de um campo
  def sum_field(det, xpath)
    xml_doc = Nokogiri::XML(det)
    namespace = { "nfe" => "http://www.portalfiscal.inf.br/nfe" }
    elements = xml_doc.xpath(xpath, namespace)
    elements.map(&:text).map(&:to_f).sum
  end

  # Geração do XML de saída
  def to_xml(infNfe)
    infNfe.ICMSTot do |total|
      total.vBC(sprintf('%.2f', @vBC))
      total.vICMS(sprintf('%.2f', @vICMS))
      total.vICMSDeson(sprintf('%.2f', @vICMSDeson))
      total.vFCPUFDest(sprintf('%.2f', @vFCPUFDest))
      total.vICMSUFDest(sprintf('%.2f', @vICMSUFDest))
      total.vICMSUFRemet(sprintf('%.2f', @vICMSUFRemet))
      total.vFCP(sprintf('%.2f', @vFCP))
      total.vBCST(sprintf('%.2f', @vBCST))
      total.vST(sprintf('%.2f', @vST))
      total.vFCPST(sprintf('%.2f', @vFCPST))
      total.vFCPSTRet(sprintf('%.2f', @vFCPSTRet))
      total.vProd(sprintf('%.2f', @vProd))
      total.vFrete(sprintf('%.2f', @vFrete))
      total.vSeg(sprintf('%.2f', @vSeg))
      total.vDesc(sprintf('%.2f', @vDesc))
      total.vII(sprintf('%.2f', @vII))
      total.vIPI(sprintf('%.2f', @vIPI))
      total.vIPIDevol(sprintf('%.2f', @vIPIDevol))
      total.vPIS(sprintf('%.2f', @vPIS))
      total.vCOFINS(sprintf('%.2f', @vCOFINS))
      total.vOutro(sprintf('%.2f', @vOutro))
      total.vNF(sprintf('%.2f', @vNF))
    end
  end
end
