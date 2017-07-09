# frozen_string_literal: true

module ErDiagram
  class Relation
    def self.candidates(db, table)
      db.entities(table)
        .select { |column| column.end_with?('_id') }
        .compact
        .map { |column| [table, column]}
    end

    def self.pluralize(name)
      name.sub(/_id$/, '') + 's'
    end

    def self.guess(db)
      tables = db.tables
      candidates = tables.map { |table| candidates(db, table)}.flatten(1)
      candidates.select do |table, column|
        relation_table = pluralize(column)
        [table, relation_table] if tables.include?(relation_table)
      end
    end
  end
end
