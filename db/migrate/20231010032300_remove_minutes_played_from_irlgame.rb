class RemoveMinutesPlayedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :minutes_played, :integer
  end
end
