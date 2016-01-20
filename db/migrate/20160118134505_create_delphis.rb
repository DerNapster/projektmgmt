class CreateDelphis < ActiveRecord::Migration
  def change
    create_table :delphis do |t|
      t.string :username, null: false
      t.references :workpackage, index: true, foreign_key: true
      t.integer :value
      t.string :workpackagename

      t.timestamps null: false
    end
  end
end
