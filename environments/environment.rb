configure do
  require 'sinatra'
  require 'xmpp4r-simple'
  require 'json'
  require 'yaml'

  # Load libraries
  Dir.glob('./lib/**/*.rb') {|f| load f } 

  # Load config file
  APP_CONFIG = YAML.load_file("./config/config.yml")

end
