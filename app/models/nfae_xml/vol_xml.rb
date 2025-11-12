class VolXml
    attr_accessor :qVol, :esp, :marca, :nVol
  
    def initialize(nfae, infNfe)
      @qVol = nfae.transp.vol.qVol
      @esp = nfae.transp.vol.esp
      @marca = nfae.transp.vol.marca
      @nVol = nfae.transp.vol.nVol
    end
  
    def to_xml(infNfe)
      infNfe.vol do |vol|
        vol.qVol(@qVol)
        vol.esp(@esp)
        vol.marca(@marca)
        vol.nVol(@nVol)
      end
    end
  end
  