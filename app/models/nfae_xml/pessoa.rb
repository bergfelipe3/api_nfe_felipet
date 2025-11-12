require 'builder'

class Pessoa
  attr_accessor :nome, :idade, :enderecos

  def initialize(nome, idade)
    @nome = nome
    @idade = idade
    @enderecos = Endereco.new('Rua A', 'Cidade A', 'Estado A')
  end

  def to_xml
    xml = Builder::XmlMarkup.new
    xml.pessoa(id: 1, ativo: 'true') do |pessoa|
      pessoa.nome @nome
      pessoa.idade @idade
      Endereco.new('Rua A', 'Cidade A', 'Estado A').to_xml(pessoa)
    end
  end

end