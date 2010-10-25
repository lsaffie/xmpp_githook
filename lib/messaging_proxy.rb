class MessagingProxy

  def self.post_yammer(message)
    require 'yammer4r'
    config_path = File.dirname(__FILE__) + 'oauth.yml'
    yammer = Yammer::Client.new(:config => config_path)                                     
    yammer.message(:post,{:body => message})
  end

  def self.post_jabber(message)
    require 'xmpp4r-simple'
    jabber_recipients = APP_CONFIG['production']['jabber_recipients']
    im = Jabber::Simple.new("user@jabber.telemonitoring.ca", "user")
    jabber_recipients.each do |jabber_recipient|
      im.deliver(jabber_recipient, message)
    end
  end

  def self.post_service(message)
    APP_CONFIG['production']['service']
    service = "post_#{APP_CONFIG['production']['service']}"
    send(service,message)
  end
end
