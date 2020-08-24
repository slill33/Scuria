class BacklogType < ApplicationRecord
  belongs_to :team

  validates :name, presence: true, uniqueness: { scope: :team_id }, length: { maximum: 255 }
end
