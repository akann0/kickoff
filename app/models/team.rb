class Team < ApplicationRecord
    validates :name, presence: true
    validates :manager, presence: true
end
