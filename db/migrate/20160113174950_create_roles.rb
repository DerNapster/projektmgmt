class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.text :qualification
      t.text :experience
      t.integer :quantity
      t.integer :level
      t.references :project, index: true, foreign_key: true
      t.references :parent, index: true
      t.timestamps null: false
    end
  end
end
