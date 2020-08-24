class Backlog < ApplicationRecord
  belongs_to :user
  has_many :backlog_columns
  has_many :children, class_name: "Backlog", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Backlog", foreign_key: "parent_id", optional: true


  before_create :ensure_super_user
  before_create :team_id_initialize

  before_destroy :ensure_super_user


  def management_team
    Team.find_by_id(self.team_id)
  end

  private
  def team_id_initialize
    self.team_id = self.user.team_id
  end

  def ensure_super_user
    unless self.user.super
      errors.add(:base, "ボードを操作する権限がありません.")
    end
    throw :abort if errors.messages[:base].present?
  end
end
