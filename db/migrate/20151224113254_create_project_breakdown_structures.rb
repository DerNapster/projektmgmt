class CreateProjectBreakdownStructures < ActiveRecord::Migration
  def change
    create_table :project_breakdown_structures do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
