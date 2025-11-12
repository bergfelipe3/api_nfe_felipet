class CreateEstadosTable < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"ESTADOS"'.freeze

  def up
    execute <<~SQL
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        "CUF" VARCHAR(2) PRIMARY KEY,
        "SIGLA" VARCHAR(2) NOT NULL,
        "NOME" VARCHAR(255) NOT NULL
      );
    SQL

    registros.each do |estado|
      execute <<~SQL
        INSERT INTO #{TABLE_NAME} ("CUF", "SIGLA", "NOME")
        VALUES (
          #{connection.quote(estado[:cuf])},
          #{connection.quote(estado[:sigla])},
          #{connection.quote(estado[:nome])}
        )
        ON CONFLICT ("CUF") DO UPDATE
          SET "SIGLA" = EXCLUDED."SIGLA",
              "NOME" = EXCLUDED."NOME";
      SQL
    end
  end

  def down
    execute "DROP TABLE IF EXISTS #{TABLE_NAME};"
  end

  private

  def registros
    [
      { cuf: '11', sigla: 'RO', nome: 'RONDÔNIA' },
      { cuf: '12', sigla: 'AC', nome: 'ACRE' },
      { cuf: '13', sigla: 'AM', nome: 'AMAZONAS' },
      { cuf: '14', sigla: 'RR', nome: 'RORAIMA' },
      { cuf: '15', sigla: 'PA', nome: 'PARÁ' },
      { cuf: '16', sigla: 'AP', nome: 'AMAPÁ' },
      { cuf: '17', sigla: 'TO', nome: 'TOCANTINS' },
      { cuf: '21', sigla: 'MA', nome: 'MARANHÃO' },
      { cuf: '22', sigla: 'PI', nome: 'PIAUÍ' },
      { cuf: '23', sigla: 'CE', nome: 'CEARÁ' },
      { cuf: '24', sigla: 'RN', nome: 'RIO GRANDE DO NORTE' },
      { cuf: '25', sigla: 'PB', nome: 'PARAÍBA' },
      { cuf: '26', sigla: 'PE', nome: 'PERNAMBUCO' },
      { cuf: '27', sigla: 'AL', nome: 'ALAGOAS' },
      { cuf: '28', sigla: 'SE', nome: 'SERGIPE' },
      { cuf: '29', sigla: 'BA', nome: 'BAHIA' },
      { cuf: '31', sigla: 'MG', nome: 'MINAS GERAIS' },
      { cuf: '32', sigla: 'ES', nome: 'ESPÍRITO SANTO' },
      { cuf: '33', sigla: 'RJ', nome: 'RIO DE JANEIRO' },
      { cuf: '35', sigla: 'SP', nome: 'SÃO PAULO' },
      { cuf: '41', sigla: 'PR', nome: 'PARANÁ' },
      { cuf: '42', sigla: 'SC', nome: 'SANTA CATARINA' },
      { cuf: '43', sigla: 'RS', nome: 'RIO GRANDE DO SUL' },
      { cuf: '50', sigla: 'MS', nome: 'MATO GROSSO DO SUL' },
      { cuf: '51', sigla: 'MT', nome: 'MATO GROSSO' },
      { cuf: '52', sigla: 'GO', nome: 'GOIÁS' },
      { cuf: '53', sigla: 'DF', nome: 'DISTRITO FEDERAL' }
    ]
  end
end
