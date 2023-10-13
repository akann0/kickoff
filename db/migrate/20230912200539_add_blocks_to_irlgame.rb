class AddBlocksToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :blocks, :integer
  end
end
