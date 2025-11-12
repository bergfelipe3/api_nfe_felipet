require 'builder'

class Subendereco
    attr_accessor :subrua, :subcidade, :subestado

  def initialize(rua, cidade, estado)
    @subrua = rua
    @subcidade = cidade
    @subestado = estado
  end

  def to_xml(endereco)
    endereco.subendereco do |subendereco|
        subendereco.subrua @subrua
        subendereco.subcidade @subcidade
        subendereco.subestado @subestado
    end
  end

end