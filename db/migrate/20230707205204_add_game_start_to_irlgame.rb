class AddGameStartToIrlgames < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :gamestart, :datetime
  end
end
