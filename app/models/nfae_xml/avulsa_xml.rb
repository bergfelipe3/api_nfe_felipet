require 'builder'

class AvulsaXml
  attr_accessor :CNPJ, :xOrgao, :matr, :xAgente, :fone, :UF, :nDAR, :dEmi, :vDAR, :repEmi, :dPag

  def initialize(nfae, infNfe)
    @CNPJ = '05599253000147'
    @xOrgao = 'SECRETARIA DE ESTADO DE FINANCAS'
    @matr = '0000000000'
    @xAgente = 'SEFIN'
    @UF = 'RO'
    @repEmi = 'repEmi'
  end

  def to_xml(infNfe)
    infNfe.avulsa do |avulsa|
      avulsa.CNPJ(@CNPJ)
      avulsa.xOrgao(@xOrgao)
      avulsa.matr(@matr)
      avulsa.xAgente(@xAgente)
      avulsa.UF(@UF)
      avulsa.repEmi(@repEmi)
    end
  end

end
