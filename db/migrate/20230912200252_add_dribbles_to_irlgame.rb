class AddDribblesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :dribbles, :integer
  end
end
