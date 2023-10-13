class CreateIrlgames < ActiveRecord::Migration[7.0]
  def change
    create_table :irlgames do |t|
      t.references :irlleague, null: false, foreign_key: true
      t.string :home
      t.string :away
      t.string :status

      t.timestamps
    end
  end
end
