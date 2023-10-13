class AddOffsidesToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :offsides, :integer
  end
end
