# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      CREATE TABLE `users` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `email` varchar(255) NOT NULL,
        `name` varchar(255) NOT NULL,
        `encrypted_password` varchar(255) NOT NULL,
        `reset_password_token` varchar(255) DEFAULT NULL,
        `reset_password_sent_at` datetime DEFAULT NULL,
        `company_id` int(11) unsigned NOT NULL,
        `super` bool DEFAULT FALSE,
        `remember_created_at` datetime DEFAULT NULL,
        `sign_in_count` int(11) NOT NULL DEFAULT '0',
        `current_sign_in_at` datetime DEFAULT NULL,
        `last_sign_in_at` datetime DEFAULT NULL,
        `current_sign_in_ip` varchar(255) DEFAULT NULL,
        `last_sign_in_ip` varchar(255) DEFAULT NULL,
        `failed_attempts` int(11) NOT NULL DEFAULT '0',
        `unlock_token` varchar(255) DEFAULT NULL,
        `locked_at` datetime DEFAULT NULL,
        `created_at` datetime NOT NULL,
        `updated_at` datetime NOT NULL,
        `deleted_at` datetime,
        PRIMARY KEY (`id`),
        UNIQUE KEY `index_users_on_email` (`email`),
        UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
        UNIQUE KEY `index_users_on_unlock_token` (`unlock_token`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8
    DDL
  end

  def down
    execute <<-DDL
      DROP TABLE `users`
    DDL
  end
end
