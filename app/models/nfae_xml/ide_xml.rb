require 'builder'

class IdeXml
  attr_accessor :cUF, :cNF, :natOp, :mod, :serie, :nNF, :dhEmi,
                :tpNF, :idDest, :cMunFG, :tpImp, :tpEmis, :cDV, :tpAmb,
                :finNFe, :indFinal, :indPres, :indIntermed, :procEmi, :verProc

  def initialize(nfae, infNfe)
    # Defina a variável de instância @nfae se necessário
    @cUF = "11" 
    @cNF = infNfe.cNF
    @natOp = gerar_natOp(nfae)
    @mod = "55" 
    @serie = infNfe.serie
    @nNF = infNfe.nNF.to_i
    @dhEmi = gerar_data
    @tpNF = "1" 
    @idDest = gerar_idDest(nfae)
    @cMunFG = "1100205"
    @tpImp = "1"
    @tpEmis = "1"
    @cDV = infNfe.cDV
    @tpAmb = nfae.ide.tpAmb
    @finNFe = gerar_finNFe(nfae)
    @indFinal = "1"
    @indPres = "9"
    @indIntermed = gerar_indIntermed(nfae)
    @procEmi = "1"
    @verProc = "NF-e"
  end

 def gerar_idDest(nfae)
    municipio = Municipio.find_by(cmundv: nfae.dest.cMun)
    return 2 if municipio.nil?
    municipio.cuf == '11' ? 1 : 2
  end

  def gerar_indIntermed(nfae)
    cfop_code = nfae.prods.map(&:CFOP)[0]
    natOp = Cfop.find_by(cfop: cfop_code)
  
    # Verifica se tpNF é igual a "1" e INDDEVOL é diferente de "1"
    if @tpNF == "1" && natOp&.inddevol != "1"
      "0" # Valor para incluir no XML
    else
      nil # Não incluir no XML
    end
  end
  
  def gerar_finNFe(nfae)
    cfop_code = nfae.prods.map(&:CFOP)[0]
    natOp = Cfop.find_by(cfop: cfop_code)
    natOp&.inddevol == "1" ? "4" : "1"
  end

  def gerar_natOp(nfae)
    cfop_code = nfae.prods.map(&:CFOP)[0] # Pega o CFOP do primeiro produto
    natOp = Cfop.find_by(cfop: cfop_code) # Busca o registro de Cfop correspondente
    natOp&.descricao.to_s[0..59] # Retorna os primeiros 60 caracteres da descrição, ou uma string vazia se não houver descrição
  end

  def gerar_data
    agora = DateTime.now
    agora.strftime('%Y-%m-%dT%H:%M:%S%:z') # Formata como AAAA-MM-DDThh:mm:ssTZD
  end


  def to_xml(infNfe)
    infNfe.ide do |ide|
      ide.cUF @cUF
      ide.cNF @cNF
      ide.natOp @natOp
      ide.mod @mod
      ide.serie @serie
      ide.nNF @nNF
      ide.dhEmi @dhEmi
      ide.tpNF @tpNF
      ide.idDest @idDest
      ide.cMunFG @cMunFG
      ide.tpImp @tpImp
      ide.tpEmis @tpEmis
      ide.cDV @cDV
      ide.tpAmb @tpAmb
      ide.finNFe @finNFe
      ide.indFinal @indFinal
      ide.indPres @indPres
      ide.indIntermed @indIntermed if @indIntermed == '0'
      ide.procEmi @procEmi
      ide.verProc @verProc
    end
  end



end