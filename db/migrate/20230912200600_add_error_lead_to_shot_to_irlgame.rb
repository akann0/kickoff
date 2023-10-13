class AddErrorLeadToShotToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :error_lead_to_shot, :integer
  end
end
