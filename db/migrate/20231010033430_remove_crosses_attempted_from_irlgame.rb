class RemoveCrossesAttemptedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :crosses_attempted, :integer
  end
end
