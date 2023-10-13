class AddKeyPassesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :key_passes, :integer
  end
end
