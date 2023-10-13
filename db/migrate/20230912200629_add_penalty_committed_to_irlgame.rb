class AddPenaltyCommittedToIrlgame < ActiveRecord::Migration[7.0]
  def change
    add_column :irlgames, :penalty_committed, :integer
  end
end
