class RemoveFoulsFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :fouls, :integer
  end
end
