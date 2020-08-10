class CreateTeams < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `teams` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        `deleted_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `teams`
    DDL
  end
end
