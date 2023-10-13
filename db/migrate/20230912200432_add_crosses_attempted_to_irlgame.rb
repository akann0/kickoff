class AddCrossesAttemptedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :crosses_attempted, :integer
  end
end
