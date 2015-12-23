class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :title
      t.integer :level
      t.references :parent

      t.timestamps null: false
    end
  end
end
