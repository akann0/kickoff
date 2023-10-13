class RemoveGroundDuelsWonFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :ground_duels_won, :integer
  end
end
