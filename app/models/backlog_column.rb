class BacklogColumn < ApplicationRecord
  belongs_to :backlog
  has_many :backlog_items, dependent: :destroy
  belongs_to :parent,   class_name: "BacklogColumn", foreign_key: "parent_id", optional: true
  has_many   :children, class_name: "BacklogColumn", foreign_key: "parent_id", dependent: :destroy

  validates :position, uniqueness: { scope: :backlog_id }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :belonging_to_backlog,       -> (b_id)           { where(backlog_id: b_id)  }
  scope :greater_than_position,      -> (position)       { where('position > ?', position)  }
  scope :shift_targets_when_destroy, -> (b_id, position) { belonging_to_backlog(b_id).greater_than_position(position) }
end
