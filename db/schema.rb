# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_11_11_121758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "CFOP", primary_key: "CFOP", id: { type: :string, limit: 4 }, force: :cascade do |t|
    t.string "DESCRICAO", limit: 255, null: false
    t.integer "INDNFE", limit: 2, null: false
    t.integer "INDCOMUNICA", limit: 2, null: false
    t.integer "INDTRANSP", limit: 2, null: false
    t.integer "INDDEVOL", limit: 2, null: false
    t.integer "INDNREF", limit: 2, null: false
  end

  create_table "ESTADOS", primary_key: "CUF", id: { type: :string, limit: 2 }, force: :cascade do |t|
    t.string "SIGLA", limit: 2, null: false
    t.string "NOME", limit: 255, null: false
  end

  create_table "MUNICIPIOS", primary_key: "CMUNDV", id: { type: :string, limit: 7 }, force: :cascade do |t|
    t.string "CUF", limit: 2, null: false
    t.string "CMUN", limit: 6, null: false
    t.string "NOME", limit: 255, null: false
  end

  create_table "NFA_AUTORIZADA", force: :cascade do |t|
    t.string "SCHEMA"
    t.string "CHAVE"
    t.string "IP"
    t.string "CPF_USUARIO"
    t.string "EMIT_ID"
    t.string "NPROT"
    t.datetime "DT_INI"
    t.datetime "DT_WS_AUTORIZACAO"
    t.string "CSTAT_CONSULTA"
    t.string "XMOTIVO_CONSULTA"
    t.string "NREC"
    t.string "NNF"
    t.string "COD_RECEITA"
    t.string "COD_RECEITA_PARTILHA"
    t.string "ATIVIDADE"
    t.string "CSTAT_AUTORIZAR"
    t.string "XMOTIVO_AUTORIZAR"
    t.datetime "DT_WS_CONSULTA"
    t.text "XML_ASSINADO_AUTORIZACAO"
    t.text "JSON_AUTORIZACAO"
    t.datetime "DT_AUTORIZACAO"
    t.datetime "DT_FIM"
    t.string "CANCELADA"
    t.string "SERIE"
    t.string "IE"
    t.string "IDARON"
    t.string "GTA"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificados", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nome", null: false
    t.text "pfx_criptografado", null: false
    t.text "senha_criptografada", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_certificados_on_nome"
    t.index ["user_id"], name: "index_certificados_on_user_id"
  end

end
