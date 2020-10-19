class User < ApplicationRecord
  belongs_to :team
  has_many :user_to_backlog_items, dependent: :destroy
  has_many :backlog_items, through: :user_to_backlog_items
  has_many :user_to_backlogs, dependent: :destroy
  has_many :backlogs, through: :user_to_backlogs
  has_many :team_roles, through: :user_to_backlogs
  has_many :api_sessions

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable, invite_for: 24.hours

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[^\s].*@[^\s].*\z/i }
end
