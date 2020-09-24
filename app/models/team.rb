class Team < ApplicationRecord
  has_many :users
  has_many :backlogs
  has_many :backlog_types
end
