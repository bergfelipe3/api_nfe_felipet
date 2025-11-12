class PISNTXml
    def initialize
      @CST = "08"
    end
  
    def to_xml(parent)
      parent.PISNT do |pisnt|
        pisnt.CST(@CST)
      end
    end
  end
  