class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
	  t.integer :idmachine
	  t.string :delay
      t.timestamps
    end
  end
end
