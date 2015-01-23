module CequelCQL2

  module SpecSupport

    Connection = Object.new

    module Helpers

      def result_stub(*results)
        ResultStub.new(results)
      end

      def connection
        Connection
      end

      def cequel
        @cequel ||= CequelCQL2::Keyspace.new({}).tap do |keyspace|
          keyspace.connection = connection
        end
      end
    end

  end

end
