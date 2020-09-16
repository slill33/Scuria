class BacklogItemToBacklogTag < ApplicationRecord
  belongs_to :backlog_item
  belongs_to :backlog_tag
end
