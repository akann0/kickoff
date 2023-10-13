class AddGroundDuelsToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :ground_duels, :integer
  end
end
