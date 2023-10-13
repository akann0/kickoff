class AddLongBallsToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :long_balls, :integer
  end
end
