class AddColumnParentId < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_columns` ADD COLUMN `parent_id` int(11) unsigned NOT NULL DEFAULT '0'
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_columns` DROP COLUMN `parent_id`
    DDL
  end
end
