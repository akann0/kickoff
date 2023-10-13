class AddPassesCompletedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :passes_completed, :integer
  end
end
