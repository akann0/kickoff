class AddFoulsToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :fouls, :integer
  end
end
