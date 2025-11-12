require 'builder'

class EnderDestXml
  attr_accessor :xLgr, :nro, :xCpl, :xBairro,
                :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone

  def initialize(nfae, infNfe)
    @xLgr = nfae.dest.xLgr
    @nro = nfae.dest.nro
    @xCpl = nfae.dest.xCpl
    @xBairro = nfae.dest.xBairro
    @cMun = nfae.dest.cMun
    @xMun = gerar_endereco(nfae)
    @UF = gerar_uf(nfae)
    @CEP = nfae.dest.CEP
    @cPais = '1058'
    @xPais = 'BRASIL'
  end

  def gerar_endereco(nfae)
    service = BuscaEnderecoService.new
    service.service(nfae.dest.cMun)
  end
  
  def gerar_uf(nfae)
    service = BuscaEnderecoService.new
    service.cuf(nfae.dest.cMun)
    service.obter_codigo_uf # Retorna o valor de @codigo_uf
  end
  

  def to_xml(infNfe)
    infNfe.enderDest do |dest|
      dest.xLgr(@xLgr)
      dest.nro(@nro)
      dest.xCpl(@xCpl)
      dest.xBairro(@xBairro)
      dest.cMun(@cMun)
      dest.xMun(@xMun)
      dest.UF(@UF)
      dest.CEP(@CEP)
      dest.cPais(@cPais)
      dest.xPais(@xPais)
    end
  end

end
