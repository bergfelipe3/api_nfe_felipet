require 'builder'

class EnderEmitXml
    attr_accessor :xLgr, :nro, :xCpl, :xBairro, :cMun,
    :xMun, :UF, :CEP, :cPais, :xPais, :fone

def initialize(nfae, infNfe)
    @xLgr = nfae.emit.xLgr
    @nro = nfae.emit.nro 
    @xCpl = nfae.emit.xCpl
    @xBairro = nfae.emit.xBairro 
    @cMun = nfae.emit.cMun 
    @xMun = gerar_endereco(nfae)
    @UF = gerar_uf(nfae)
    @CEP = nfae.emit.CEP
    @cPais = '1058' 
    @xPais = 'Brasil' 
    @fone = nfae.emit.fone
end

  def gerar_endereco(nfae)
    service = BuscaEnderecoService.new
    service.service(nfae.emit.cMun)
  end
  
  def gerar_uf(nfae)
    service = BuscaEnderecoService.new
    service.cuf(nfae.emit.cMun)
    service.obter_codigo_uf # Retorna o valor de @codigo_uf
  end
  

  def to_xml(infNfe)
    infNfe.enderEmit do |enderemit|
      enderemit.xLgr @xLgr
      enderemit.nro @nro
      enderemit.xCpl @xCpl
      enderemit.xBairro @xBairro
      enderemit.cMun @cMun
      enderemit.xMun @xMun
      enderemit.UF @UF
      enderemit.CEP @CEP
      enderemit.cPais @cPais
      enderemit.xPais @xPais
      enderemit.fone @fone
    end
  end
  


end