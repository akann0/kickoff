class RemovePossessionLostFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :possession_lost, :integer
  end
end
