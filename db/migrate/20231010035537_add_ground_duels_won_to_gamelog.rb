class AddGroundDuelsWonToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :ground_duels_won, :integer
  end
end
