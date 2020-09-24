class User < ApplicationRecord
  has_many :backlogs
  has_many :team_to_users
  has_many :teams, through: :team_to_users
  has_many :user_to_backlog_items
  has_many :backlog_items, through: :user_to_backlog_items

  acts_as_paranoid
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable, invite_for: 24.hours

  validates :name,  presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[^\s].*@[^\s].*\z/i  }

end
