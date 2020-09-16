class TeamToUsers < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `team_to_users` (
        `id` int(11) unsigned AUTO_INCREMENT,
        `team_id` int(11) unsigned NOT NULL DEFAULT '0',
        `user_id` int(11) unsigned NOT NULL DEFAULT '0',
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY(`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `team_to_users`
    DDL
  end
end
