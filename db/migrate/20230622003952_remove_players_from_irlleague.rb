class RemovePlayersFromIrlleague < ActiveRecord::Migration[7.0]
  def change
    remove_reference :irlleagues, :players, null: false, foreign_key: true
  end
end
