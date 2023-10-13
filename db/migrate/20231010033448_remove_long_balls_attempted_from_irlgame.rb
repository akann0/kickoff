class RemoveLongBallsAttemptedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :long_balls_attempted, :integer
  end
end
