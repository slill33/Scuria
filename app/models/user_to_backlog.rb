class UserToBacklog < ApplicationRecord
  belongs_to :user
  belongs_to :backlog
end
