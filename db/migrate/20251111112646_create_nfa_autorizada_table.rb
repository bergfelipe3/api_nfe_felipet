class CreateNfaAutorizadaTable < ActiveRecord::Migration[7.1]
  TABLE_NAME = '"NFA_AUTORIZADA"'.freeze

  def up
    create_table TABLE_NAME do |t|
      t.string :"SCHEMA"
      t.string :"CHAVE"
      t.string :"IP"
      t.string :"CPF_USUARIO"
      t.string :"EMIT_ID"
      t.string :"NPROT"
      t.datetime :"DT_INI"
      t.datetime :"DT_WS_AUTORIZACAO"
      t.string :"CSTAT_CONSULTA"
      t.string :"XMOTIVO_CONSULTA"
      t.string :"NREC"
      t.string :"NNF"
      t.string :"COD_RECEITA"
      t.string :"COD_RECEITA_PARTILHA"
      t.string :"ATIVIDADE"
      t.string :"CSTAT_AUTORIZAR"
      t.string :"XMOTIVO_AUTORIZAR"
      t.datetime :"DT_WS_CONSULTA"
      t.text :"XML_ASSINADO_AUTORIZACAO"
      t.text :"JSON_AUTORIZACAO"
      t.datetime :"DT_AUTORIZACAO"
      t.datetime :"DT_FIM"
      t.string :"CANCELADA"
      t.string :"SERIE"
      t.string :"IE"
      t.string :"IDARON"
      t.string :"GTA"
      t.timestamps
    end
  end

  def down
    drop_table TABLE_NAME
  end
end
