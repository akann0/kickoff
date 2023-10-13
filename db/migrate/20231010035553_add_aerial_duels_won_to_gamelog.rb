class AddAerialDuelsWonToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :aerial_duels_won, :integer
  end
end
