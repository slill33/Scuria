class UserToBacklog < ApplicationRecord
  belongs_to :user
  belongs_to :backlog
  belongs_to :team_role
end
