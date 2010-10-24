class YammerProxy

  def self.post_yammer(message)
    require 'yammer4r'
    config_path = File.dirname(__FILE__) + 'oauth.yml'
    yammer = Yammer::Client.new(:config => config_path)                                     
    yammer.message(:post,{:body => message})
  end
end
