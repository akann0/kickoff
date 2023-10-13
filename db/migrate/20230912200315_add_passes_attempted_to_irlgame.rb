class AddPassesAttemptedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :passes_attempted, :integer
  end
end
