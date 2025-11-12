class TransportaXml
  attr_accessor :modFrete, :CNPJ, :CPF, :xNome, :IE, :xEnder, :xMun, :UF

  def initialize(nfae, infNfe)
    @nfae = nfae
    @infNfe = infNfe
    @CNPJ = nfae.transp.transporta.CNPJ
    @CPF = nfae.transp.transporta.CPF
    @xNome = nfae.transp.transporta.xNome
    @IE = nfae.transp.transporta.IE
    @xEnder = nfae.transp.transporta.xEnder
    @xMun = nfae.transp.transporta.xMun
    @UF = nfae.transp.transporta.UF
  end

  def to_xml(infNfe)
    infNfe.transporta do |transporta|
      transporta.CPF(@CPF) if @CPF && !@CPF.empty?
      transporta.CNPJ(@CNPJ) if @CNPJ && !@CNPJ.empty?
      transporta.xNome(@xNome) if @xNome && !@xNome.empty?
      transporta.IE(@IE) if @IE && !@IE.empty?
      transporta.xEnder(@xEnder) if @xEnder && !@xEnder.empty?
      transporta.xMun(@xMun) if @xMun && !@xMun.empty?
      transporta.UF(@UF)
    end
  end
end
