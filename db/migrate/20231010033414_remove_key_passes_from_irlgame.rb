class RemoveKeyPassesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :key_passes, :integer
  end
end
