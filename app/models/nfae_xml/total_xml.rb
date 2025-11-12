require 'nokogiri'

class TotalXml

  def initialize(nfae, infNfe, det)
    @nfae = nfae
    @infNfe = infNfe
    @det = det
 
  end

  # Geração do XML de saída
  def to_xml(infNfe)
    infNfe.total do |total|
        ICMSTotXml.new(@nfae, @infNfe, @det).to_xml(total)
    end
  end
end
