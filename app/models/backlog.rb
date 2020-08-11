class Backlog < ApplicationRecord
  belongs_to :user
  #belongs_to :team
  has_many :backlog_columns
  has_many :children, class_name: "Backlog", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Backlog", foreign_key: "parent_id", optional: true

  #TODO backlogs <-> teams の関連付け方針
end
