# This sinatra app receives a post from github and
# posts a message over xmpp to our jabber server
#
# Author <luis@saffie.ca>

require 'sinatra'
require 'xmpp4r-simple'

class XmppGithook < Sinatra::Base
  get '/' do
    'hello worldy'
  end

  post '/' do
    post = params[:payload]
    require 'ruby-debug'
    debugger
    im = Jabber::Simple.new("user@jabber.telemonitoring.ca", "user")
    im.deliver("lsaffie@jabber.telemonitoring.ca", post.inspect)
  end
end

XmppGithook.run!
