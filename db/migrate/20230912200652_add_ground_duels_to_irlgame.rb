class AddGroundDuelsToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :ground_duels, :integer
  end
end
