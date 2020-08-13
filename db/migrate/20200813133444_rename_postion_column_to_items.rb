class RenamePostionColumnToItems < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE `backlog_items` CHANGE `position` `priority` int(11) unsigned;
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE `backlog_items` CHANGE `priority` `position` int(11) unsigned;
    DDL
  end

end
