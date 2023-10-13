class AddCrossesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :crosses, :integer
  end
end
