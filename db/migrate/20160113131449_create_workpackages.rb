class CreateWorkpackages < ActiveRecord::Migration
  def change
    create_table :workpackages do |t|
      t.string :name
      t.text :description
      t.text :result
      t.text :interfaces
      t.string :purchaser
      t.integer :level
      t.integer :duration
      t.date :startdate
      t.date :enddate
      t.text :activities
      t.text :requirements
      t.decimal :costs
      t.integer :work
      t.decimal :workPerformed, :default => 0.0
      t.references :project, index: true, foreign_key: true
      t.references :parent, index: true

      t.timestamps null: false
    end
  end
end
