class AddPassesCompletedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :passes_completed, :integer
  end
end
