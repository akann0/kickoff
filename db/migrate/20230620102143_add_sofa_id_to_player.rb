class AddSofaIdToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :sofaid, :string
  end
end
