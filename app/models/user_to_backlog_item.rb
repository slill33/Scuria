class UserToBacklogItem < ApplicationRecord
  belongs_to :user
  belongs_to :backlog_item
  belongs_to :backlog
end
