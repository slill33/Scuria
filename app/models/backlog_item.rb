class BacklogItem < ApplicationRecord
  belongs_to :backlog_column

  validates :position, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_point(point)
    self.update(point: point)
  end
end
