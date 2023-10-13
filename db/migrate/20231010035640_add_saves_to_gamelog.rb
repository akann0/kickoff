class AddSavesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :saves, :integer
  end
end
