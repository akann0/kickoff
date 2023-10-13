class AddInterceptionsToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :interceptions, :integer
  end
end
