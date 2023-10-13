class RemoveGroundDuelsFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :ground_duels, :integer
  end
end
