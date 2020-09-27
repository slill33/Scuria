class BacklogDropColunUserId < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlogs` DROP COLUMN `user_id`
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlogs` ADD COLUMN `user_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end
end
