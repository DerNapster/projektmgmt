class CreateDelphis < ActiveRecord::Migration
  def change
    create_table :delphis do |t|
      t.string :name
      t.references :workpackage, index: true, foreign_key: true
      t.integer :round
      t.integer :pessimistic
      t.integer :realistic
      t.integer :optimistic

      t.timestamps null: false
    end
  end
end
