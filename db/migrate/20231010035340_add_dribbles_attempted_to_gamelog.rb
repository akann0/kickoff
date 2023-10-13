class AddDribblesAttemptedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :dribbles_attempted, :integer
  end
end
