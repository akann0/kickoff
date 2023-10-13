class AddClearancesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :clearances, :integer
  end
end
