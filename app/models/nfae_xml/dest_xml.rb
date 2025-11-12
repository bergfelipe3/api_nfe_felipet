require 'builder'

class DestXml
  attr_accessor :CNPJ, :xNome, :xLgr, :nro, :xCpl, :xBairro,
                :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone, :indIEDest, :IE

  def initialize(nfae, infNfe)
    @nfae = nfae
    @CNPJ = nfae.dest.CNPJ
    @xNome = nfae.dest.xNome
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
    @fone = nfae.dest.fone
    @indIEDest = nfae.dest.indIEDest
    @IE = nfae.dest.IE
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
    infNfe.dest do |dest|
      dest.CNPJ(@CNPJ)
      dest.xNome(@xNome)
      EnderDestXml.new(@nfae, self).to_xml(dest) 
      dest.indIEDest(@indIEDest)
      dest.IE(@IE) 
    end
  end

end
