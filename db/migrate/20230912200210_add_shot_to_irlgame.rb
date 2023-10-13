class AddShotToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :shots, :integer
  end
end
