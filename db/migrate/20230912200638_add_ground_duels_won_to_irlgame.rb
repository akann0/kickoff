class AddGroundDuelsWonToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :ground_duels_won, :integer
  end
end
