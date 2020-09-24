class Team < ApplicationRecord
  has_many :users
  has_many :backlogs, through: :users
  has_many :backlog_types
  has_many :users
end
