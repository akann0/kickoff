class RemoveDribblesFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :dribbles, :integer
  end
end
