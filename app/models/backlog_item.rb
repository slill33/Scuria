class BacklogItem < ApplicationRecord
  belongs_to :backlog_column
  belongs_to :parent,   class_name: "BacklogItem", foreign_key: "parent_id", optional: true
  has_many   :backlog_item_comments
  has_many   :children, class_name: "BacklogItem", foreign_key: "parent_id", dependent: :destroy
  has_many   :backlog_item_to_backlog_tags
  has_many   :backlog_tags, through: :backlog_item_to_backlog_tags
  belongs_to :backlog

  validates :priority, uniqueness: { scope: [:backlog_id, :backlog_column_id] }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
