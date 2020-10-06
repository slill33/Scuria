class AddUserToBacklogs < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `user_to_backlogs` ADD COLUMN `team_role_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `user_to_backlogs` DROP COLUMN `team_role_id`
    DDL
  end
end
