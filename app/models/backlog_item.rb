class BacklogItem < ApplicationRecord
  belongs_to :backlog_column

  validates :position, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_priority(priority)
    self.update(priority: priority)
  end
end
