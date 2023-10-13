class RemoveShotsOnGoalFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :shots_on_goal, :integer
  end
end
