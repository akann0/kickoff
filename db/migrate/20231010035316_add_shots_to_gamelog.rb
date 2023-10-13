class AddShotsToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :shots, :integer
  end
end
