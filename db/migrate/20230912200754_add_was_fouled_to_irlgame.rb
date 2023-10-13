class AddWasFouledToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :was_fouled, :integer
  end
end
