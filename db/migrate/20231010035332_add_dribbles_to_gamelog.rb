class AddDribblesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :dribbles, :integer
  end
end
