class Backlog < ApplicationRecord
  has_many :backlog_columns
  has_many :backlog_tags
  has_many :children, class_name: "Backlog", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Backlog", foreign_key: "parent_id", optional: true
  belongs_to :backlog_type
  has_many :backlog_items
  has_many :user_to_backlogs, dependent: :destroy
  has_many :users, through: :user_to_backlogs
  has_many :user_to_backlog_items
  #has_many :team_roles, through: :user_to_backlogs
  has_many :child_backlog_items, class_name: "BacklogItem", foreign_key: "child_backlog_id"

  #before_create :ensure_super_user
  #before_create :team_id_initialize
  before_create :set_unique_hashcode
  #before_destroy :ensure_super_user

  include RandomDigestGenerator

  HASHCODE_LENGTH = 16

  def management_team
    Team.find_by_id(self.team_id)
  end

  private

  def team_id_initialize
    #self.team_id = self.user.team_id
  end

  def ensure_super_user
    #unless self.user.super
    #  errors.add(:base, "ボードを操作する権限がありません.")
    #end
    #throw :abort if errors.messages[:base].present?
  end

  concerning :Hashcode do
    def set_unique_hashcode
      while true
        hashcode = RandomDigestGenerator.random_digest(HASHCODE_LENGTH)
        break if Backlog.where(hashcode: hashcode).blank?
      end
      self.hashcode = hashcode
    end
  end
end
