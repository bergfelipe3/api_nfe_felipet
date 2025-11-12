require 'builder'

class ICMSXml
  attr_accessor :nItem

  def initialize(nfae, nItem)
    @nfae = nfae
    @nItem = nItem
  end

  def to_xml(parent)
    parent.ICMS do |icms|
      cst = @nfae.prods[@nItem]
      case cst.CST
      when '00'
        ICMSCST00Xml.new(@nfae, @nItem).to_xml(icms)
      when '20'
        ICMSCST20Xml.new(@nfae, @nItem).to_xml(icms)
      when '41'
        ICMSCST40Xml.new(@nfae, @nItem).to_xml(icms)
      else
        raise "Apenas CST com o valor 00, 20, e 40: #{cst}"
      end
    end
  end
end
