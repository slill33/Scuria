class Backlog < ApplicationRecord
  belongs_to user
  has_many backlog_columns
end
