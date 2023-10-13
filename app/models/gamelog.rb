class Gamelog < ApplicationRecord
    belongs_to :player
    belongs_to :irlgame
end
