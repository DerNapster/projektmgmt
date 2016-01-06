class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :description
      t.integer :level
      t.integer :duration
      t.date :startdate
      t.date :enddate
      t.boolean :milestone
      t.references :pbstable, index: true, foreign_key: true
      t.references :node, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
