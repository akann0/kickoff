class AddDribblesAttemptedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :dribbles_attempted, :integer
  end
end
