class CreateDelphis < ActiveRecord::Migration
  def change
    create_table :delphis do |t|
      t.string :name
      t.references :workpackage, index: true, foreign_key: true
      t.int :round
      t.int :pessimistic
      t.int :realistic
      t.int :optimistic

      t.timestamps null: false
    end
  end
end
