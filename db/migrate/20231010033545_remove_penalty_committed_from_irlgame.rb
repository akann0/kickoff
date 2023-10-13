class RemovePenaltyCommittedFromIrlgame < ActiveRecord::Migration[7.0]
  def change
    remove_column :irlgames, :penalty_committed, :integer
  end
end
