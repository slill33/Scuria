class CreateApiSessions < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `api_sessions` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `user_id` int(11) unsigned NOT NULL DEFAULT '0',
        `hash_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
        `expire_at` datetime DEFAULT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `api_sessions`
    DDL
  end
end
