class AddColumnBacklogItemParentId < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_items` ADD COLUMN `parent_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_items` DROP COLUMN `parent_id`
    DDL
  end
end
