class TeamRole < ApplicationRecord
  DEFAULT_NAMES = %w(ScrumMaster ProductOwner Member)
  belongs_to :team
  has_many :user_to_backlogs, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :team_id }, length: { maximum: 255 }
end
