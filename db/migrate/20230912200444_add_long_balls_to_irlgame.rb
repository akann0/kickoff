class AddLongBallsToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :long_balls, :integer
  end
end
