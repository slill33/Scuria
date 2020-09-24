class CreateBacklogItemComments < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `backlog_item_comments` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `content` text NOT NULL,
        `backlog_item_id` int(11) unsigned NOT NULL DEFAULT '0',
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `backlog_item_comments`
    DDL
  end
end
