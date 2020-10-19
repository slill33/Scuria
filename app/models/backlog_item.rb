class BacklogItem < ApplicationRecord
  belongs_to :backlog_column
  belongs_to :parent, class_name: "BacklogItem", foreign_key: "parent_id", optional: true
  has_many :user_to_backlog_items
  has_many :users, through: :user_to_backlog_items
  has_many :backlog_item_comments
  has_many :children, class_name: "BacklogItem", foreign_key: "parent_id", dependent: :destroy
  has_many :backlog_item_to_backlog_tags
  has_many :backlog_tags, through: :backlog_item_to_backlog_tags
  belongs_to :backlog
  belongs_to :child_backlog, class_name: "Backlog", foreign_key: "child_backlog_id", optional: true

  validates :priority, uniqueness: { scope: [:backlog_id, :backlog_column_id] }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :belonging_to_backlog_column, ->(bc_id) { where(backlog_column_id: bc_id) }
  scope :greater_than_priority, ->(priority) { where("priority > ?", priority) }
  scope :shift_targets_when_destroy, ->(bc_id, priority) { belonging_to_backlog_column(bc_id).greater_than_priority(priority) }
end
