# This sinatra app receives a post from github and
# posts a message over xmpp to our jabber server
#
# Author <luis@saffie.ca>

require 'sinatra'
require 'xmpp4r-simple'
require 'json'

class XmppGithook < Sinatra::Base
  get '/' do
    'hello worldy'
  end

  post '/' do
    post = params[:payload]
    message = parse_post(post)
    im = Jabber::Simple.new("user@jabber.telemonitoring.ca", "user")
    im.deliver("lsaffie@jabber.telemonitoring.ca", message)
  end

  def parse_post(post)
    json = JSON.parse(post)
    commit = json["commits"][0]
    repo = json["repository"]
    string = "#{commit['author']['name']} commited to #{repo["name"]}"
    string
  end
end

XmppGithook.run!
