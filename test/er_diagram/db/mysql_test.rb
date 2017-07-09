# frozen_string_literal: true

require "test_helper"
require 'er_diagram/db/mysql'

class MySQLTest < Minitest::Test

  SCHEMA = 'er_diagram_test'
  CONNECTION_URI = 'mysql2://localhost/information_schema?user=root'

  #TODO: move to fixtures
  SCHEMA_MIGRATION_CREATE_SQL = 'CREATE TABLE schema_migrations (version varchar(255) COLLATE utf8_unicode_ci NOT NULL, UNIQUE KEY unique_schema_migrations (version)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci'
  USERS_CREATE_SQL = 'CREATE TABLE users (id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, email varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, created_at datetime DEFAULT NULL, updated_at datetime DEFAULT NULL, password_digest varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL, PRIMARY KEY (id), UNIQUE KEY index_users_on_email (email)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci'


  def mysql_command(sql, db = nil)
    command = %{mysql -u root -e "#{sql}"}
    command += " -D #{db}" unless db.nil?
    `#{command}`
  end

  def setup
    mysql_command("DROP DATABASE IF EXISTS #{SCHEMA}")
    mysql_command("CREATE DATABASE #{SCHEMA}")
    mysql_command(SCHEMA_MIGRATION_CREATE_SQL, SCHEMA)
    mysql_command(USERS_CREATE_SQL, SCHEMA)

    @mysql = ErDiagram::DB::MySQL.new(CONNECTION_URI, SCHEMA)
  end

  def test_it_create_mysql_connection
    assert_equal ErDiagram::DB::MySQL, @mysql.class
  end

  def test_it_has_tables
    actual = @mysql.tables
    assert_equal Array, actual.class
    assert_equal true, actual.include?('users')
    assert_equal false, actual.include?('schema_migrations')
  end

  def test_it_has_entities
    expects = %w[id name  email  created_at  updated_at password_digest].sort
    assert_equal @mysql.entities('users').sort, expects
  end
end
