class AddPossessionLostToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :possession_lost, :integer
  end
end
