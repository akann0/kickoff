class AddCrossesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :crosses, :integer
  end
end
