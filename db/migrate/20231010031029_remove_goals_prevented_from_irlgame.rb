class RemoveGoalsPreventedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :goals_prevented, :integer
  end
end
