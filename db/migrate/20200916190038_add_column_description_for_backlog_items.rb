class AddColumnDescriptionForBacklogItems < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_items` ADD COLUMN `description` text NOT NULL
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_items` DROP COLUMN `description`
    DDL
  end
end
