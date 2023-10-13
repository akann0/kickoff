class AddAerialDuelsToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :aerial_duels, :integer
  end
end
