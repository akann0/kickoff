class RemoveErrorLeadToGoalFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :error_lead_to_goal, :integer
  end
end
