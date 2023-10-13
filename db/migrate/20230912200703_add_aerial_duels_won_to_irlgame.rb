class AddAerialDuelsWonToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :aerial_duels_won, :integer
  end
end
