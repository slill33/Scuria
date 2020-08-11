class Backlog < ApplicationRecord
  belongs_to :user
  #belongs_to :team
  has_many :backlog_columns
  has_many :children, class_name: "Backlog", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Backlog", foreign_key: "parent_id", optional: true

  #TODO backlogs <-> teams の関連付け方針

  validate :team_id_check, on: :create


  private
  def team_id_check
    return if self.user.team_id == self.team_id
    errors.add(:team_id, ": Invalid team_id is set.")
  end
end
