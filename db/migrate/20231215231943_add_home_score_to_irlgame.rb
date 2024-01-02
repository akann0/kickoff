class AddHomeScoreToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :home_score, :integer
  end
end
