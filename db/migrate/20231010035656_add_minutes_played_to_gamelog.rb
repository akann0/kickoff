class AddMinutesPlayedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :minutes_played, :integer
  end
end
