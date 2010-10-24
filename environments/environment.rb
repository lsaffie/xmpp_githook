configure do
  require 'sinatra'
  require 'xmpp4r-simple'
  require 'json'

  # Load libraries
  Dir.glob('./lib/**/*.rb') {|f| load f } 

end
