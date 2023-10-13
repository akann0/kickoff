class AddAerialDuelsToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :aerial_duels, :integer
  end
end
