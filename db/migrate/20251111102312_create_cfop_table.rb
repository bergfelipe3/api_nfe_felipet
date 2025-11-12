class CreateCfopTable < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"CFOP"'.freeze

  def up
    execute <<~SQL
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        "CFOP" VARCHAR(4) PRIMARY KEY,
        "DESCRICAO" VARCHAR(255) NOT NULL,
        "INDNFE" SMALLINT NOT NULL,
        "INDCOMUNICA" SMALLINT NOT NULL,
        "INDTRANSP" SMALLINT NOT NULL,
        "INDDEVOL" SMALLINT NOT NULL,
        "INDNREF" SMALLINT NOT NULL
      );
    SQL

    registros_cfop.each do |r|
      execute <<~SQL
        INSERT INTO #{TABLE_NAME} ("CFOP", "DESCRICAO", "INDNFE", "INDCOMUNICA", "INDTRANSP", "INDDEVOL", "INDNREF")
        VALUES (
          #{connection.quote(r[:cfop])},
          #{connection.quote(r[:descricao])},
          #{r[:indnfe]},
          #{r[:indcomunica]},
          #{r[:indtransp]},
          #{r[:inddevol]},
          #{r[:indnref]}
        )
        ON CONFLICT ("CFOP") DO NOTHING;
      SQL
    end
  end

  def down
    execute "DROP TABLE IF EXISTS #{TABLE_NAME};"
  end

  private

  def registros_cfop
    [
      { cfop: '5101', descricao: 'Venda de produção do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5102', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, ou qualquer venda de mercadoria efetuada pelo MEI.', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5103', descricao: 'Venda de produção do estabelecimento efetuada fora do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5104', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, efetuada fora do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5105', descricao: 'Venda de produção do estabelecimento que não deva por ele transitar', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5106', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5109', descricao: 'Venda de produção do estabelecimento destinada à ZFM ou ALC', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5110', descricao: 'Venda de mercadoria, adquirida ou recebida de terceiros, destinada à ZFM ou ALC', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5111', descricao: 'Venda de produção do estabelecimento remetida anteriormente em consignação industrial', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5112', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros remetida anteriormente em consignação industrial', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5113', descricao: 'Venda de produção do estabelecimento remetida anteriormente em consignação mercantil', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5114', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros remetida anteriormente em consignação mercantil', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5115', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, recebida anteriormente em consignação mercantil', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5116', descricao: 'Venda de produção do estabelecimento originada de encomenda p/ entrega futura', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5117', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros, originada de encomenda p/ entrega futura', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 1 },
      { cfop: '5118', descricao: 'Venda de produção do estabelecimento entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5119', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5120', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário pelo vendedor remetente, em venda à ordem', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5122', descricao: 'Venda de produção do estabelecimento remetida p/ industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5123', descricao: 'Venda de mercadoria adquirida ou recebida de terceiros remetida p/ industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5124', descricao: 'Industrialização efetuada p/ outra empresa', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5125', descricao: 'Industrialização efetuada p/ outra empresa quando a mercadoria recebida p/ utilização no processo de industrialização não transitar pelo estabelecimento adquirente da mercadoria', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5129', descricao: 'Venda de insumo importado e de mercadoria industrializada sob o amparo do Regime Aduaneiro Especial de Entreposto Industrial (Recof-Sped)', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5151', descricao: 'Transferência de produção do estabelecimento', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5152', descricao: 'Transferência de mercadoria adquirida ou recebida de terceiros', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5201', descricao: 'Devolução de compra p/ industrialização ou produção rural', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 1, indnref: 1 },
      { cfop: '5251', descricao: 'Venda de energia elétrica p/ distribuição ou comercialização', indnfe: 1, indcomunica: 0, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5301', descricao: 'Prestação de serviço de comunicação p/ execução de serviço da mesma natureza', indnfe: 0, indcomunica: 1, indtransp: 0, inddevol: 0, indnref: 0 },
      { cfop: '5351', descricao: 'Prestação de serviço de transporte p/ execução de serviço da mesma natureza', indnfe: 0, indcomunica: 0, indtransp: 1, inddevol: 0, indnref: 0 }
    ]
  end
end
