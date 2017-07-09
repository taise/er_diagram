# frozen_string_literal: true

require "test_helper"
require 'fixtures/mysql_setup'
require 'er_diagram/db/mysql'
require 'er_diagram/relation'

class RelationTest < Minitest::Test
  SCHEMA = 'er_diagram_test'
  CONNECTION_URI = 'mysql2://localhost/information_schema?user=root'

  def setup
    MySQLSetup.run
    @db = ErDiagram::DB::MySQL.new(CONNECTION_URI, SCHEMA)
  end

  def test_it_guess_relation_between_tables
    actual = ErDiagram::Relation.guess(@db)
    assert_equal Array, actual.class
    assert_equal 2, actual.size
    assert actual.include?(['user_roles', 'users'])
    assert actual.include?(['user_roles', 'roles'])
  end

  def test_it_makes_table_name_be_pluralize
    assert_equal 'users', ErDiagram::Relation.pluralize('user')
    # FIXME: 'chiled' translate to 'children'
    assert_equal 'childs', ErDiagram::Relation.pluralize('child')
  end
end
