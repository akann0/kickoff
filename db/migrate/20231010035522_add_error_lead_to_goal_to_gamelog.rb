class AddErrorLeadToGoalToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :error_lead_to_goal, :integer
  end
end
