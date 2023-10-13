class RemoveClearancesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :clearances, :integer
  end
end
