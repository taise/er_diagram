module ErDiagram
  module DB
    class Engine
      def self.connect
        raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
      end

      def tables
        raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
      end
    end
  end
end
