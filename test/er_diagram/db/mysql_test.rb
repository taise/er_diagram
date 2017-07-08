require "test_helper"
require 'er_diagram/db/mysql'

class MySQLTest < Minitest::Test
  def setup
    `mysql -u root -e "DROP DATABASE IF EXISTS er_diagram_test"`
    `mysql -u root -e "CREATE DATABASE er_diagram_test"`
    `mysql -u root -D er_diagram_test -e "CREATE TABLE schema_migrations (version varchar(255) COLLATE utf8_unicode_ci NOT NULL, UNIQUE KEY unique_schema_migrations (version)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"`
    `mysql -u root -D er_diagram_test -e "CREATE TABLE users (id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, email varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, created_at datetime DEFAULT NULL, updated_at datetime DEFAULT NULL, password_digest varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, remember_token varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, admin tinyint(1) DEFAULT NULL, PRIMARY KEY (id), UNIQUE KEY index_users_on_email (email), KEY index_users_on_remember_token (remember_token)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"`
  end

  CONNECTION_URI = 'mysql2://localhost/er_diagram_test?user=root'

  def test_it_can_connect
    assert_equal ErDiagram::DB::MySQL, ErDiagram::DB::MySQL.connect(CONNECTION_URI).class
  end

  def test_it_has_tables
    actual = ErDiagram::DB::MySQL.connect(CONNECTION_URI).tables
    assert_equal Array, actual.class
    assert_equal true, actual.include?('users')
    assert_equal false, actual.include?('schema_migrations')
  end
end
