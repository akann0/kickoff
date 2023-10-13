class AddCrossesAttemptedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :crosses_attempted, :integer
  end
end
