class AddMunicipiosRecords < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"MUNICIPIOS"'.freeze

  def up
    registros.each do |municipio|
      execute <<~SQL
        INSERT INTO #{TABLE_NAME} ("CUF", "CMUNDV", "CMUN", "NOME")
        VALUES (
          #{connection.quote(municipio[:cuf])},
          #{connection.quote(municipio[:cmundv])},
          #{connection.quote(municipio[:cmun])},
          #{connection.quote(municipio[:nome])}
        )
        ON CONFLICT ("CMUNDV") DO UPDATE
          SET "CUF" = EXCLUDED."CUF",
              "CMUN" = EXCLUDED."CMUN",
              "NOME" = EXCLUDED."NOME";
      SQL
    end
  end

  def down
    cmundvs = registros.map { |registro| connection.quote(registro[:cmundv]) }.join(', ')
    execute <<~SQL
      DELETE FROM #{TABLE_NAME}
      WHERE "CMUNDV" IN (#{cmundvs});
    SQL
  end

  private

  def registros
    [
      { cuf: '11', cmundv: '1100114', cmun: '110011', nome: 'ARIQUEMES' }
    ]
  end
end
