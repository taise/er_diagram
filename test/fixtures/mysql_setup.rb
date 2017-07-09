# frozen_string_literal: true
require 'pathname'

class MySQLSetup
  SCHEMA = 'er_diagram_test'

  def self.mysql_command(sql, db = nil)
    command = %{mysql -u root -e "#{sql}"}
    command += " -D #{db}" unless db.nil?
    `#{command}`
  end

  def self.run
    mysql_command("DROP DATABASE IF EXISTS #{SCHEMA}")
    mysql_command("CREATE DATABASE #{SCHEMA}")
    mysql_command(File.read(Pathname(__FILE__).parent / 'mysql.sql'), SCHEMA)
  end
end
