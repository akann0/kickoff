class AddErrorLeadToGoalToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :error_lead_to_goal, :integer
  end
end
