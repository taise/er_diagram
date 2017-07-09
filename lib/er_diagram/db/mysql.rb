# frozen_string_literal: true

require_relative '../engine'
require 'sequel'
require 'mysql2'

module ErDiagram
  module DB
    class MySQL < Engine

      def initialize(uri, schema)
        @conn = Sequel.connect(uri)
        @schema = schema
      end

      def tables
        @conn[:tables]
          .where(table_schema: @schema)
          .select(:table_name)
          .map(&:values)
          .flatten
          .reject {|table| table == 'schema_migrations' }
      end

      def entities(table)
        @conn[:columns]
          .where(table_schema: @schema, table_name: table)
          .select(:column_name)
          .map(&:values)
          .flatten
      end
    end
  end
end
