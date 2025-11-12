class Estado < ApplicationRecord
  self.table_name = '"ESTADOS"'
  self.primary_key = 'CUF'

  alias_attribute :cuf, 'CUF'
  alias_attribute :sigla, 'SIGLA'
  alias_attribute :nome, 'NOME'
end
