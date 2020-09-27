class CreateBacklogItemToBacklogTags < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `backlog_item_to_backlog_tags` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `backlog_item_id` int(11) unsigned NOT NULL DEFAULT '0',
        `backlog_tag_id` int(11) unsigned NOT NULL DEFAULT '0',
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `backlog_item_to_backlog_tags`
    DDL
  end
end
