require 'active_support/core_ext'
require 'cassandra-cql'
require 'connection_pool'

require 'cequel_cql2/batch'
require 'cequel_cql2/errors'
require 'cequel_cql2/cql_row_specification'
require 'cequel_cql2/data_set'
require 'cequel_cql2/keyspace'
require 'cequel_cql2/row_specification'
require 'cequel_cql2/statement'

module CequelCQL2
  def self.connect(configuration = nil)
    Keyspace.new(configuration || {})
  end
end
