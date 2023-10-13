class AddShotsOnGoalToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :shots_on_goal, :integer
  end
end
