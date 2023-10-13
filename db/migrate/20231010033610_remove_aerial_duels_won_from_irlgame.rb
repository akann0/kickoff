class RemoveAerialDuelsWonFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :aerial_duels_won, :integer
  end
end
