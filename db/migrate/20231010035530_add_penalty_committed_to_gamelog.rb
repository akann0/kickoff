class AddPenaltyCommittedToGamelog < ActiveRecord::Migration[7.0]
  def change
    add_column :gamelogs, :penalty_committed, :integer
  end
end
