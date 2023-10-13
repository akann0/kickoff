class Player < ApplicationRecord
  belongs_to :team
  belongs_to :irlleague

  has_many :gamelogs
end

            