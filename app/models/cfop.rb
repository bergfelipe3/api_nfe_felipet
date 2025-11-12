class Cfop < ApplicationRecord
  self.table_name = '"CFOP"'
  self.primary_key = 'CFOP'

  alias_attribute :cfop, 'CFOP'
  alias_attribute :descricao, 'DESCRICAO'
  alias_attribute :indnfe, 'INDNFE'
  alias_attribute :indcomunica, 'INDCOMUNICA'
  alias_attribute :indtransp, 'INDTRANSP'
  alias_attribute :inddevol, 'INDDEVOL'
  alias_attribute :indnref, 'INDNREF'
end
