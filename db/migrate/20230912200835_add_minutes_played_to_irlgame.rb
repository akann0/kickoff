class AddMinutesPlayedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :minutes_played, :integer
  end
end
