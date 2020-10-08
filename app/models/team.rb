class Team < ApplicationRecord
  has_many :users
  has_many :backlogs
  has_many :backlog_types
  has_many :team_roles

  after_create :create_default_backlog_type
  after_create :create_default_team_roles

  def create_default_backlog_type
    return unless self.backlog_types.empty?

    BacklogType::DEFAULT_NAMES.each { |default_type_name|
      self.backlog_types.create!(name: default_type_name)
    }
  end

  def create_default_team_roles
    return unless self.team_roles.empty?

    TeamRole::DEFAULT_NAMES.each { |default_type_name|
      self.team_roles.create!(name: default_type_name)
    }
  end
end
