class RemoveInterceptionsFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :interceptions, :integer
  end
end
