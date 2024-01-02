class AddAwayScoreToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :away_score, :integer
  end
end
