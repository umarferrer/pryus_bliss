class PingMachine < ActiveRecord::Migration
  def up
	create_table :ping do |t|
      t.integer :id_machine
      t.string :delay
	end
end
  def down
  end
end
