class Backlog < ApplicationRecord
  belongs_to :user
  has_many :backlog_columns

  #TODO backlogs <-> teams の関連付け方針
end
