class COFINSNTXml
    def initialize
      @CST = "08"
    end

    def to_xml(parent)
      parent.COFINSNT do |confins|
        confins.CST(@CST)
      end
    end
  end