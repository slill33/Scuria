class CreateBacklogs < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `backlogs` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
        `user_id` int(11) unsigned NOT NULL DEFAULT '0',
        `team_id` int(11) unsigned NOT NULL DEFAULT '0',
        `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `backlogs`
    DDL
  end
end
