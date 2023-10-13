class AddUrlToIrlgames < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :url, :string
  end
end
