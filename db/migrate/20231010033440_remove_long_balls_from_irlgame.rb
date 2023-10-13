class RemoveLongBallsFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :long_balls, :integer
  end
end
