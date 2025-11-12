class DetXml
  attr_accessor :nItem

  def initialize(nfae, infNfe, index)
    @nfae = nfae
    @nItem = index
  end

  def to_xml(infNfe)
    infNfe.det(nItem: @nItem) do |det|
      ProdXml.new(@nfae, @nItem - 1).to_xml(det)
      ImpostoXml.new(@nfae, @nItem - 1).to_xml(det)
    end
  end
end
