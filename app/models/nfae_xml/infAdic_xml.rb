class InfAdicXml
  attr_accessor :tPag, :vPag

  def initialize(nfae, infNfe)
    @infAdFisco = 'A licitude da operacao, a descricao das mercadorias e/ou bens e a veracidade dos dados informados, sao de total responsabilidade do remetente. A autorizacao do documento nao significa a validacao da SEFIN/RO com relacao as informacoes nele contidas.'
    @infCpl = nfae.infAdic.infCpl
  end

  def to_xml(infNfe)
    infNfe.infAdic do |inf|
      inf.infAdFisco(@infAdFisco)
      inf.infCpl(@infCpl)
    end
  end
end
