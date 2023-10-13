class CreateIrlleagues < ActiveRecord::Migration[7.0]
  def change
    create_table :irlleagues do |t|
      t.references :players, null: false, foreign_key: true
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
