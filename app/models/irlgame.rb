class Irlgame < ApplicationRecord
  belongs_to :irlleague

  has_many :gamelogs
end
