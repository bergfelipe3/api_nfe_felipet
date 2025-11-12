class CreateMunicipiosTable < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"MUNICIPIOS"'.freeze

  def up
    execute <<~SQL
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        "CUF" VARCHAR(2) NOT NULL,
        "CMUNDV" VARCHAR(7) PRIMARY KEY,
        "CMUN" VARCHAR(6) NOT NULL,
        "NOME" VARCHAR(255) NOT NULL
      );
    SQL

    registros.each do |m|
      execute <<~SQL
        INSERT INTO #{TABLE_NAME} ("CUF", "CMUNDV", "CMUN", "NOME")
        VALUES (
          #{connection.quote(m[:cuf])},
          #{connection.quote(m[:cmundv])},
          #{connection.quote(m[:cmun])},
          #{connection.quote(m[:nome])}
        )
        ON CONFLICT ("CMUNDV") DO NOTHING;
      SQL
    end
  end

  def down
    execute "DROP TABLE IF EXISTS #{TABLE_NAME};"
  end

  private

  def registros
    [
      { cuf: '11', cmundv: '1100015', cmun: '110001', nome: "ALTA FLORESTA D'OESTE" },
      { cuf: '11', cmundv: '1100023', cmun: '110002', nome: 'ARIQUEMES' },
      { cuf: '11', cmundv: '1100031', cmun: '110003', nome: 'CABIXI' },
      { cuf: '11', cmundv: '1100049', cmun: '110004', nome: 'CACOAL' },
      { cuf: '11', cmundv: '1100056', cmun: '110005', nome: 'CEREJEIRAS' },
      { cuf: '11', cmundv: '1100064', cmun: '110006', nome: 'COLORADO DO OESTE' },
      { cuf: '11', cmundv: '1100072', cmun: '110007', nome: 'CORUMBIARA' },
      { cuf: '11', cmundv: '1100080', cmun: '110008', nome: 'COSTA MARQUES' },
      { cuf: '11', cmundv: '1100098', cmun: '110009', nome: "ESPIGÃO D'OESTE" },
      { cuf: '11', cmundv: '1100106', cmun: '110010', nome: 'GUAJARÁ-MIRIM' },
      { cuf: '11', cmundv: '1100114', cmun: '110011', nome: 'JARU' },
      { cuf: '11', cmundv: '1100122', cmun: '110012', nome: 'JI-PARANÁ' },
      { cuf: '11', cmundv: '1100130', cmun: '110013', nome: "MACHADINHO D'OESTE" },
      { cuf: '11', cmundv: '1100148', cmun: '110014', nome: 'NOVA BRASILÂNDIA D’OESTE' },
      { cuf: '11', cmundv: '1100155', cmun: '110015', nome: 'OURO PRETO DO OESTE' },
      { cuf: '11', cmundv: '1100189', cmun: '110018', nome: 'PIMENTA BUENO' },
      { cuf: '11', cmundv: '1100205', cmun: '110020', nome: 'PORTO VELHO' },
      { cuf: '11', cmundv: '1100254', cmun: '110025', nome: 'PRESIDENTE MÉDICI' },
      { cuf: '11', cmundv: '1100288', cmun: '110028', nome: 'ROLIM DE MOURA' },
      { cuf: '11', cmundv: '1100304', cmun: '110030', nome: 'VILHENA' },
      { cuf: '11', cmundv: '1100452', cmun: '110045', nome: 'BURITIS' },
      { cuf: '11', cmundv: '1100502', cmun: '110050', nome: 'NOVO HORIZONTE DO OESTE' }
    ]
  end
end
