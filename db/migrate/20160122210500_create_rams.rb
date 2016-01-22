class CreateRams < ActiveRecord::Migration
  def change
    create_table :rams do |t|
      t.references :workpackage, index: true, foreign_key: true
      t.references :node, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.integer :level
      t.integer :order

      t.timestamps null: false
    end
  end
end
