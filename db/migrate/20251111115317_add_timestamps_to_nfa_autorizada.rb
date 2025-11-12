class AddTimestampsToNfaAutorizada < ActiveRecord::Migration[7.1]
  def up
    change_table :"NFA_AUTORIZADA" do |t|
      t.change :created_at, :datetime, null: true
      t.change :updated_at, :datetime, null: true
    end
  end

  def down
    change_table :"NFA_AUTORIZADA" do |t|
      t.change :created_at, :datetime, null: false
      t.change :updated_at, :datetime, null: false
    end
  end
end
