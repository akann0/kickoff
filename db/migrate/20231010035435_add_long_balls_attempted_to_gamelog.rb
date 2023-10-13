class AddLongBallsAttemptedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :long_balls_attempted, :integer
  end
end
