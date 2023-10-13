class RemoveBlocksFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :blocks, :integer
  end
end
