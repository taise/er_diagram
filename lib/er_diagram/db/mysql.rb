require_relative '../engine'
require 'sequel'
require 'mysql2'

module ErDiagram
  module DB
    class MySQL < Engine
      TABLES_SQL = 'show tables'

      def self.connect(uri)
        @@conn = Sequel.connect(uri)
        self.new
      end

      def tables
        @@conn.fetch(TABLES_SQL)
          .map(&:values)
          .flatten
          .reject {|table| table == 'schema_migrations' }
      end
    end
  end
end
