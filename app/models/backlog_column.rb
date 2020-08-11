class BacklogColumn < ApplicationRecord
  belongs_to :backlog
  has_many :backlog_items

  validates :position, uniqueness: true
end
