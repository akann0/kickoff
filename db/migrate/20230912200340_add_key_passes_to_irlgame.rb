class AddKeyPassesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :key_passes, :integer
  end
end
