class RemoveTacklesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :tackles, :integer
  end
end
