class AddShotsOnGoalToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :shots_on_goal, :integer
  end
end
