class AddColumnChildBacklogIdToBacklogItems < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_items` ADD COLUMN `child_backlog_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_items` DROP COLUMN `child_backlog_id`
    DDL
  end
end
