class AddLongBallsAttemptedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :long_balls_attempted, :integer
  end
end
