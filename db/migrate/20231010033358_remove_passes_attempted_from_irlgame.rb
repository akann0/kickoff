class RemovePassesAttemptedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :passes_attempted, :integer
  end
end
