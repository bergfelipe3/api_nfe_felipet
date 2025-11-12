class Municipio < ApplicationRecord
  self.table_name = '"MUNICIPIOS"'
  self.primary_key = 'CMUNDV'

  alias_attribute :cuf, 'CUF'
  alias_attribute :cmundv, 'CMUNDV'
  alias_attribute :cmun, 'CMUN'
  alias_attribute :nome, 'NOME'
end
