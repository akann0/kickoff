class CreateGamelogs < ActiveRecord::Migration[7.0]
  def change
    create_table :gamelogs do |t|
      t.integer :goals
      t.integer :assists
      t.string :status
      t.integer :fpoints

      t.timestamps
    end
  end
end
