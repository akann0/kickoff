class RemoveSavesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :saves, :integer
  end
end
