class Configuration

    #sender = APP_CONFIG['production']['jabber_sender']
    #sender_password = APP_CONFIG['production']['jabber_sender_password']
    #receiver = APP_CONFIG['production']['jabber_recipients']
    #jabber_alias = APP_CONFIG['production']['jabber_alias']

  def get(key)
    APP_CONFIG['production'][key]
  end

end
