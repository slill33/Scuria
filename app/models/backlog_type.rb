class BacklogType < ApplicationRecord
  belongs_to :team
  has_many :backlog

  validates :name, presence: true, uniqueness: { scope: :team_id }, length: { maximum: 255 }
end
