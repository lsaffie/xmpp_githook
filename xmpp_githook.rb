# This sinatra app receives a post from github and
# posts a message over xmpp to our jabber server
#
# Author <luis@saffie.ca>

require 'sinatra'

class XmppGithook < Sinatra::Base
  get '/' do
    'hello worldy'
  end
end

XmppGithook.run!
