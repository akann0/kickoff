class RemoveOffsidesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :offsides, :integer
  end
end
