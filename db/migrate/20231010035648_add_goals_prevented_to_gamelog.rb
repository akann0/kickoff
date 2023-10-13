class AddGoalsPreventedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :goals_prevented, :integer
  end
end
