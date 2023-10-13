class AddGoalsPreventedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :goals_prevented, :integer
  end
end
