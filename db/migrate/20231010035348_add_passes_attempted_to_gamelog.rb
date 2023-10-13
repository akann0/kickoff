class AddPassesAttemptedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :passes_attempted, :integer
  end
end
