# frozen_string_literal: true

require "test_helper"
require 'er_diagram/db/mysql'

class MySQLTest < Minitest::Test

  DATABASE = 'er_diagram_test'
  CONNECTION_URI = 'mysql2://localhost/er_diagram_test?user=root'

  #TODO: move to fixtures
  SCHEMA_MIGRATION_CREATE_SQL = 'CREATE TABLE schema_migrations (version varchar(255) COLLATE utf8_unicode_ci NOT NULL, UNIQUE KEY unique_schema_migrations (version)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci'
  USERS_CREATE_SQL = 'CREATE TABLE users (id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, email varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, created_at datetime DEFAULT NULL, updated_at datetime DEFAULT NULL, password_digest varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, remember_token varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, admin tinyint(1) DEFAULT NULL, PRIMARY KEY (id), UNIQUE KEY index_users_on_email (email), KEY index_users_on_remember_token (remember_token)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci'


  def mysql_command(sql, db = nil)
    command = %{mysql -u root -e "#{sql}"}
    command += " -D #{db}" unless db.nil?
    `#{command}`
  end

  def setup
    mysql_command("DROP DATABASE IF EXISTS #{DATABASE}")
    mysql_command("CREATE DATABASE #{DATABASE}")
    mysql_command(SCHEMA_MIGRATION_CREATE_SQL, DATABASE)
    mysql_command(USERS_CREATE_SQL, DATABASE)
  end

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
