class AddPlayerToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_reference :gamelogs, :player, null: false, foreign_key: true
  end
end
