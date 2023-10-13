class RemoveShotFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :shots, :integer
  end
end
