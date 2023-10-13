class RemovePassesCompletedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :passes_completed, :integer
  end
end
