class RemoveCrossesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :crosses, :integer
  end
end
