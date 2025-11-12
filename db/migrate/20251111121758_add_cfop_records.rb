class AddCfopRecords < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"CFOP"'.freeze

  def up
    registros.each do |registro|
      execute <<~SQL
        INSERT INTO #{TABLE_NAME} ("CFOP", "DESCRICAO", "INDNFE", "INDCOMUNICA", "INDTRANSP", "INDDEVOL", "INDNREF")
        VALUES (
          #{connection.quote(registro[:cfop])},
          #{connection.quote(registro[:descricao])},
          #{registro[:indnfe]},
          #{registro[:indcomunica]},
          #{registro[:indtransp]},
          #{registro[:inddevol]},
          #{registro[:indnref]}
        )
        ON CONFLICT ("CFOP") DO UPDATE
          SET "DESCRICAO" = EXCLUDED."DESCRICAO",
              "INDNFE" = EXCLUDED."INDNFE",
              "INDCOMUNICA" = EXCLUDED."INDCOMUNICA",
              "INDTRANSP" = EXCLUDED."INDTRANSP",
              "INDDEVOL" = EXCLUDED."INDDEVOL",
              "INDNREF" = EXCLUDED."INDNREF";
      SQL
    end
  end

  def down
    cfops = registros.map { |registro| connection.quote(registro[:cfop]) }.join(', ')
    execute <<~SQL
      DELETE FROM #{TABLE_NAME}
      WHERE "CFOP" IN (#{cfops});
    SQL
  end

  private

  def registros
    [
      { cfop: '5101', descricao: 'Venda de produção do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5102', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, ou qualquer venda de mercadoria efetuada pelo MEI.', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5103', descricao: 'Venda de produção do estabelecimento efetuada fora do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5104', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, efetuada fora do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 }
    ]
  end
end
