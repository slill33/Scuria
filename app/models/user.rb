class User < ApplicationRecord
  #has_many :backlog_items, through: :user_to_backlog_items
  belongs_to :team
  #belongs_to :backlog_members
  
  acts_as_paranoid
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable, invite_for: 24.hours
         #invite_key: {team_id:""}

end
