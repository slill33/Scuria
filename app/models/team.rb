class Team < ApplicationRecord
    has_many :users
    has_many :backlogs, through: :users
end
