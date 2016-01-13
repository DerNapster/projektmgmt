class CreateWbstables < ActiveRecord::Migration
  def change
    create_table :wbstables do |t|
      t.string :name
      t.references :project, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
