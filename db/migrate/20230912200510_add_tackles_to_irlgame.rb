class AddTacklesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :tackles, :integer
  end
end
