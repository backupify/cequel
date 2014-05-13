module Cequel

  module Model

    #
    # Encapsulates information about a column in a model's column family
    #
    class Column
      attr_reader :name, :type, :default

      def initialize(name, type, options = {})
        @name, @type = name, type
        @default = options[:default]
      end

      def self.convert_cql(obj)
        case obj
        when SimpleUUID::UUID
          obj.to_guid
        else
          obj
        end
      end
    end

  end

end
