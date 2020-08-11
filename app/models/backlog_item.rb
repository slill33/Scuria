class BacklogItem < ApplicationRecord
  belongs_to :backlog_column

  validates :position, uniqueness: true
end
