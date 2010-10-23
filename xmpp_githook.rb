# This sinatra app receives a post from github and
# posts a message over xmpp to our jabber server
#
# Author <luis@saffie.ca>

require 'sinatra'
require 'xmpp4r-simple'
require 'json'

class XmppGithook < Sinatra::Base
  post '/' do
    post = params[:payload]
    if post
      message = parse_post(post)
      post_yammer(message)
    end
  end

  def parse_post(post)
    json = JSON.parse(post)
    commit = json["commits"][0]
    repo = json["repository"]
    string = "#{commit['author']['name']} commited to #{repo["name"]}"
    string
  end

  def post_yammer(message)
    require 'yammer4r'
    config_path = File.dirname(__FILE__) + 'oauth.yml'
    yammer = Yammer::Client.new(:config => config_path)
    yammer.message(:post,{:body => message})
  end
end

XmppGithook.run!
