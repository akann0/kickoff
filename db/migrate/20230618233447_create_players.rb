class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.string :sofascoreid
      t.references :team, null: false, foreign_key: true
      t.string :nationality
      t.string :rlteam

      t.timestamps
    end
  end
end
