class RemoveAerialDuelsFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :aerial_duels, :integer
  end
end
