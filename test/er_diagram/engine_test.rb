require "test_helper"
require 'er_diagram/db/engine'

class EngineTest < Minitest::Test
  def test_it_cant_connect
    assert_raises NotImplementedError do
      ErDiagram::DB::Engine.connect
    end
  end

  def test_it_has_tables
    assert_raises NotImplementedError do
      ErDiagram::DB::Engine.connect.tables
    end
  end
end
