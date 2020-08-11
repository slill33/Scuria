class BacklogColumn < ApplicationRecord
  belongs_to backlog
  has_many backlog_items
end
