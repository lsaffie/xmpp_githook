# This sinatra app receives a post from github and
# posts a message over xmpp to our jabber server
#
# Author <luis@saffie.ca>

# Load environment
Dir.glob('./environments/*.rb') { |f| load f }

post '/' do
  post = params[:payload]
  if post
    message = PushWireProtocol::parse_post(post)
    YammerProxy::post_yammer(message)
  end
end
