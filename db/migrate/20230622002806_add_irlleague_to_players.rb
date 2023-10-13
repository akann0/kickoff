class AddIrlleagueToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :irlleague, null: false, foreign_key: true
  end
end
