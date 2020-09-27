class Team < ApplicationRecord
  has_many :users
  has_many :backlogs
  has_many :backlog_types

  after_create :create_default_backlog_type


  def create_default_backlog_type
    return unless self.backlog_types.empty?

    BacklogType::DEFAULT_NAMES.each {|default_type_name|
      self.backlog_types.create!(name: default_type_name)
    }
  end

end
