class AddSavesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :saves, :integer
  end
end
