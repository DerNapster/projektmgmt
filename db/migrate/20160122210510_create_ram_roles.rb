class CreateRamRoles < ActiveRecord::Migration
  def change
    create_table :ram_roles do |t|
      t.references :role, index: true, foreign_key: true
      t.references :ram, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
