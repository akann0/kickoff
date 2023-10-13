class AddIrlGameToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_reference :gamelogs, :irlgame, null: false, foreign_key: true
  end
end
