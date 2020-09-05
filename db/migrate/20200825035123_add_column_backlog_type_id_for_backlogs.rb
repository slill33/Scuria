class AddColumnBacklogTypeIdForBacklogs < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlogs` ADD COLUMN `backlog_type_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlogs` DROP COLUMN `backlog_type_id`
    DDL
  end
end
