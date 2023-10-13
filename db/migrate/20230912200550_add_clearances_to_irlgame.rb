class AddClearancesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :clearances, :integer
  end
end
