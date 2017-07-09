# frozen_string_literal: true

require 'graphviz'

module ErDiagram
  class Diagram
    def self.output(db, tables, file: 'er_diagram.png')
      g = GraphViz.new( :G, :type => :digraph )

      # FIXME: ducktyping
      nodes = {}
      db.tables.each { |table| nodes[table] = g.add_nodes(table) }

      ErDiagram::Relation.guess(db).each do |table, relation_table|
        g.add_edges(nodes[table], nodes[relation_table] )
      end

      g.output( png: file)
    end
  end
end

require_relative '../../test/fixtures/mysql_setup'
require 'er_diagram/db/mysql'
require 'er_diagram/relation'

SCHEMA = 'er_diagram_test'
CONNECTION_URI = 'mysql2://localhost/information_schema?user=root'

MySQLSetup.run

db = ErDiagram::DB::MySQL.new(CONNECTION_URI, SCHEMA)
ErDiagram::Diagram.output(db, db.tables)
