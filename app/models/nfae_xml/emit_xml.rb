require 'builder'

class EmitXml
    attr_accessor :CPF, :xNome, :xFant, :IE, :CRT

def initialize(nfae, infNfe)
    @nfae = nfae
    @CPF = nfae.emit.CPF 
    @xNome = nfae.emit.xNome 
    @xFant = nfae.emit.xFant 
    @IE = nfae.emit.IE
    @CRT = '3'
end

  def to_xml(infNfe)
    infNfe.emit do |emit|
      emit.CPF @CPF
      emit.xNome @xNome
      emit.xFant @xFant
      EnderEmitXml.new(@nfae, self).to_xml(emit) 
      emit.IE @IE
      emit.CRT @CRT
    end
  end
  


end