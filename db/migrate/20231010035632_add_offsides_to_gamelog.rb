class AddOffsidesToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :offsides, :integer
  end
end
