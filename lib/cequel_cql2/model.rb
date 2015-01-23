require 'active_model'
require 'rails-observers'

require 'cequel_cql2'
require 'cequel_cql2/model/associations'
require 'cequel_cql2/model/callbacks'
require 'cequel_cql2/model/class_internals'
require 'cequel_cql2/model/column'
require 'cequel_cql2/model/counter'
require 'cequel_cql2/model/dictionary'
require 'cequel_cql2/model/dirty'
require 'cequel_cql2/model/dynamic'
require 'cequel_cql2/model/errors'
require 'cequel_cql2/model/inheritable'
require 'cequel_cql2/model/instance_internals'
require 'cequel_cql2/model/local_association'
require 'cequel_cql2/model/mass_assignment_security'
require 'cequel_cql2/model/magic'
require 'cequel_cql2/model/naming'
require 'cequel_cql2/model/observer'
require 'cequel_cql2/model/persistence'
require 'cequel_cql2/model/properties'
require 'cequel_cql2/model/remote_association'
require 'cequel_cql2/model/scope'
require 'cequel_cql2/model/scoped'
require 'cequel_cql2/model/subclass_internals'
require 'cequel_cql2/model/timestamps'
require 'cequel_cql2/model/translation'
require 'cequel_cql2/model/validations'

if defined? Rails
  require 'cequel_cql2/model/railtie'
end

module CequelCQL2

  #
  # This module adds Cassandra persistence to a class using CequelCQL2.
  #
  module Model

    @lock = Monitor.new

    extend ActiveSupport::Concern
    extend ActiveModel::Observing::ClassMethods

    included do
      @_cequel = ClassInternals.new(self)

      include Properties
      include Persistence
      include Scoped
      include Naming
      include Callbacks
      include Validations
      include ActiveModel::Observing
      include Dirty
      include MassAssignmentSecurity
      include Associations
      extend Inheritable
      extend Magic

      include ActiveModel::Serializers::JSON
      include ActiveModel::Serializers::Xml

      # This is needed to maintain correct to_json from Rails 3.2.9 to rails 4
      self.include_root_in_json = true

      extend Translation
    end

    def self.keyspace
      @lock.synchronize do
        @keyspace ||= CequelCQL2.connect(@configuration).tap do |keyspace|
          keyspace.logger = @logger if @logger
          keyspace.slowlog = @slowlog if @slowlog
          keyspace.slowlog_threshold = @slowlog_threshold if @slowlog_threshold
        end
      end
    end

    def self.configure(configuration)
      @configuration = configuration
    end

    def self.logger=(logger)
      @logger = logger
    end

    def self.slowlog=(slowlog)
      @slowlog = slowlog
    end

    def self.slowlog_threshold=(slowlog_threshold)
      @slowlog_threshold = slowlog_threshold
    end

    def initialize
      @_cequel = InstanceInternals.new(self)
    end

  end

end
