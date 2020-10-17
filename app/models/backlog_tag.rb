class BacklogTag < ApplicationRecord
  belongs_to :backlog
  has_many :backlog_item_to_backlog_tags, dependent: :destroy
  has_many :backlog_items, through: :backlog_item_to_backlog_tags

  validates :name, presence: true, uniqueness: { scope: :backlog_id }, length: { maximum: 255 }
end
