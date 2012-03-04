class MessagingProxy

  def self.post_yammer(message)
    require 'yammer4r'
    config_path = './oauth.yml'
    yammer = Yammer::Client.new(:config => config_path)
    yammer.message(:post,{:body => message})
  end

  def self.post_jabber(message)
    require 'xmpp4r'
    require 'xmpp4r/muc'

    config = Configuration.new

    client = Jabber::Client.new(Jabber::JID.new(config.get('jabber_sender')))
    client.connect
    client.auth(config.get('jabber_sender_password'))

    msg=Jabber::Message::new(nil, message)

    muc = Jabber::MUC::MUCClient.new(client)
    muc.join(Jabber::JID.new(config.get('jabber_recipients') + '/' + config.get('jabber_alias')))
    muc.send(msg)
    muc.exit()
  end

  def self.post_service(message)
    APP_CONFIG['production']['service']
    service = "post_#{APP_CONFIG['production']['service']}"
    send(service,message)
  end
end
