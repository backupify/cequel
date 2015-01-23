require File.expand_path('../../spec_helper', __FILE__)
require 'cequel_cql2/model'

Dir.glob(File.join(File.dirname(__FILE__), '../../models/**/*.rb')).each do |file|
  require file
end

RSpec.configure do |config|
  config.before :each do
    CequelCQL2::Model.keyspace.connection = connection
  end
end
