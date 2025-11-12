class CreateCertificados < ActiveRecord::Migration[7.1]
  def change
    create_table :certificados do |t|
      t.bigint :user_id
      t.string :nome, null: false
      t.text :pfx_criptografado, null: false
      t.text :senha_criptografada, null: false

      t.timestamps
    end

    add_index :certificados, :user_id
    add_index :certificados, :nome
  end
end
