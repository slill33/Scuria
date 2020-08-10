class User < ApplicationRecord
  #has_many :backlog_items, through: :user_to_backlog_items
  belongs_to :company 
  #belongs_to :backlog_members
  
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable
end
