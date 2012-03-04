class Configuration

    #sender = APP_CONFIG['production']['jabber_sender']
    #sender_password = APP_CONFIG['production']['jabber_sender_password']
    #receiver = APP_CONFIG['production']['jabber_recipients']
    #jabber_alias = APP_CONFIG['production']['jabber_alias']

  attr_accessor :bot, :bot_password, :bot_alias
  attr_accessor :recipients

  def initialize()
    @bot          = Configuration.get('jabber_sender')
    @bot_password = Configuration.get('jabber_sender_password')
    @bot_alias    = Configuration.get('jabber_alias')
    @recipients   = Configuration.get('jabber_recipients')
  end

  def self.get(key)
    APP_CONFIG['production'][key]
  end

end
