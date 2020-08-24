class BacklogColumn < ApplicationRecord
  belongs_to :backlog
  has_many :backlog_items

  validates :position, uniqueness: { scope: :backlog_id }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
