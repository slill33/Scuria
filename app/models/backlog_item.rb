class BacklogItem < ApplicationRecord
  belongs_to :backlog_column
  has_many   :children, class_name: "BacklogItem", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent,   class_name: "BacklogItem", foreign_key: "parent_id", optional: true
  has_many :user_to_backlog_items
  has_many :users, through: :user_to_backlog_items

  validates :priority, uniqueness: { scope: [:backlog_id, :backlog_column_id] }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
