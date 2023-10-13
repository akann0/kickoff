class AddWasFouledToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :was_fouled, :integer
  end
end
