require 'builder'

class ImpostoXml
  attr_accessor :nItem

  def initialize(nfae, nItem)
    @nItem = nItem
    @nfae = nfae
  end

  def to_xml(parent)
    parent.imposto do |imposto|
        ICMSXml.new(@nfae, @nItem - 1).to_xml(imposto) 
        IPIXml.new(@nfae, @nItem - 1).to_xml(imposto)
        PISXml.new(@nfae, @nItem - 1).to_xml(imposto)
        COFINSXml.new(@nfae, @nItem - 1).to_xml(imposto)
    end
  end
end
