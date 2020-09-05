class AddColumnColorForBacklogColumn < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_columns` ADD COLUMN `color` varchar(8) NOT NULL DEFAULT ''
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_columns` DROP COLUMN `color`
    DDL
  end
end
