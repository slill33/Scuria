class User < ApplicationRecord
  #has_many :backlog_items, through: :user_to_backlog_items
  has_many :backlogs
  belongs_to :team
  #belongs_to :backlog_members
  
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable
end
