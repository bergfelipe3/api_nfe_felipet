class IPINTXml
    def initialize
      @CST = "53"
    end
  
    def to_xml(parent)
      parent.IPINT do |ipint|
        ipint.CST(@CST)
      end
    end
  end
  