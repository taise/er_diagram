# frozen_string_literal: true

require "test_helper"
require 'fixtures/mysql_setup'
require 'er_diagram/db/mysql'

class MySQLTest < Minitest::Test

  SCHEMA = 'er_diagram_test'
  CONNECTION_URI = 'mysql2://localhost/information_schema?user=root'

  def setup
    MySQLSetup.run
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
