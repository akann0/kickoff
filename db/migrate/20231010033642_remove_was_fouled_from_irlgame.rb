class RemoveWasFouledFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :was_fouled, :integer
  end
end
