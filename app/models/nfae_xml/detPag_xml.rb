class DetPagXml
  attr_accessor :tPag, :xPag, :vPag

  def initialize(nfae, infNfe, vNF)
    @tPag = nfae.pag.tPag
    @xPag = gerar_xpag
    @vPag = gerar_vPag(vNF)
  end

  def gerar_xpag
    formas_pagamento = {
      "01" => "Dinheiro",
      "02" => "Cheque",
      "03" => "Cartão de Crédito",
      "04" => "Cartão de Débito",
      "05" => "Crédito Loja",
      "10" => "Vale Alimentação",
      "11" => "Vale Refeição",
      "12" => "Vale Presente",
      "13" => "Vale Combustível",
      "15" => "Boleto Bancário",
      "16" => "Depósito Bancário",
      "17" => "Pagamento Instantâneo (PIX)",
      "18" => "Transferência bancária, Carteira Digital",
      "19" => "Programa de fidelidade, Cashback, Crédito Virtual",
      "90" => "Sem pag",
      "99" => "Outros"
    }
    formas_pagamento[@tPag]
  end

  def gerar_vPag(p_vPag)
   
    if @tPag != '90'
      return p_vPag
    else
      return '0.00'
    end
    
  end


  def to_xml(infNfe)
    infNfe.detPag do |detpag|
      detpag.tPag(@tPag)
      # detpag.xPag(@xPag) if @tPag != '90'
      detpag.vPag(sprintf('%.2f', @vPag))
    end
  end
end
