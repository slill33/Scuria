class CreateBacklogItems < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `backlog_items` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
        `point` int(11) unsigned NOT NULL DEFAULT '0',
        `position` int(11) unsigned NOT NULL DEFAULT '0',
        `user_id` int(11) unsigned NOT NULL DEFAULT '0',
        `backlog_column_id` int(11) unsigned NOT NULL DEFAULT '0',
        `backlog_tag_id` int(11) unsigned NOT NULL DEFAULT '0',
        `completed_at` datetime DEFAULT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `backlog_items`
    DDL
  end
end
