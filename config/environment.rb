require 'bundler/setup'
Bundler.require

ENV['SINATRA_ENV'] ||= "production"

ActiveRecord::Base.establish_connection(
  :adapter => "postgres",
  :database => "db/nyc#{ENV['SINATRA_ENV']}.postgres"
)

require_relative "../app/controllers/application_controller.rb"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}
