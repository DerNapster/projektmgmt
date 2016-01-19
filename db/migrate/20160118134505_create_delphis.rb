class CreateDelphis < ActiveRecord::Migration
  def change
    create_table :delphis do |t|
      t.string :name, null: false
      t.references :workpackage, index: true, foreign_key: true
      t.integer :value

      t.timestamps null: false
    end
  end
end
