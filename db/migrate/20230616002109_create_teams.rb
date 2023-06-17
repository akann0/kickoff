class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :manager
      t.string :name
      t.integer :wins
      t.integer :losses
      t.integer :draws

      t.timestamps
    end
  end
end
