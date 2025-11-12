require 'builder'

class Endereco
    attr_accessor :rua, :cidade, :estado, :subendereco

  def initialize(rua, cidade, estado)
    @rua = rua
    @cidade = cidade
    @estado = estado
  end

  def to_xml(pessoa)
    pessoa.endereco do |endereco|
      endereco.rua @nome
      endereco.cidade @cidade
      endereco.estado @estado
      Subendereco.new('Rua A', 'Cidade A', 'Estado A').to_xml(endereco)
    end
  end

end