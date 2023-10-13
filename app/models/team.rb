class Team < ApplicationRecord
    has_many :players
    
    validates :name, presence: true
    validates :manager, presence: true
end
