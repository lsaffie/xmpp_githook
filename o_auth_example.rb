# example run:
# 
# ruby o_auth_example.rb request_token
#{"oauth_token_secret"=>"gGrldPFoa3kIr6Kz7C4DQe0hUxXFWQ24Qim1c48MC4",
# "oauth_callback_confirmed"=>"true",
#  "oauth_token"=>"W9XroyIS6ZePW7qD8kAh5g"}
#
# open browser to https://www.yammer.com/oauth/authorize?oauth_token=W9XroyIS6ZePW7qD8kAh5g
# get back verifier code 1234
#
# ruby o_auth_example.rb access_token W9XroyIS6ZePW7qD8kAh5g gGrldPFoa3kIr6Kz7C4DQe0hUxXFWQ24Qim1c48MC4 1234
#{"oauth_token_secret"=>"y7QP8oUq9NUpXmBs1q727SSqlX0EBzxmuEavbU7YA",
# "oauth_token"=>"OuSqrNQWQVm1LHHmNfmmg"}
#
# ruby o_auth_example.rb messages OuSqrNQWQVm1LHHmNfmmg y7QP8oUq9NUpXmBs1q727SSqlX0EBzxmuEavbU7YA
# [json]
#
# ruby o_auth_example.rb post OuSqrNQWQVm1LHHmNfmmg y7QP8oUq9NUpXmBs1q727SSqlX0EBzxmuEavbU7YA
# [json]


require 'pp'
require 'net/http'
require 'net/https'

CONSUMER_KEY = 'CqmJDFaWUMgJvhQxv8aOyA'
CONSUMER_SECRET = 'ZRPdUI8qUBjopONUmmOvJC7WleEtOrgGveaKIDw'

class OAuthExample

  def headers(token, token_secret, oauth_verifier)
    values = {}
    values[:realm]                  = ''
    values[:oauth_consumer_key]     = CONSUMER_KEY
    values[:oauth_token]            = token if token
    values[:oauth_signature_method] = 'PLAINTEXT'
    values[:oauth_signature]        = "#{CONSUMER_SECRET}%26"
    values[:oauth_signature]        = "#{CONSUMER_SECRET}%26#{token_secret}" if token_secret
    values[:oauth_timestamp]        = Time.now.to_i
    values[:oauth_nonce]            = Time.now.to_i
    values[:oauth_version]          = '1.0a'
    values[:oauth_verifier]         = oauth_verifier if oauth_verifier

    buffer = []
    [:realm, :oauth_consumer_key, :oauth_token, :oauth_signature_method, 
     :oauth_signature, :oauth_timestamp, :oauth_nonce, :oauth_version, :oauth_verifier].each do |key|
      buffer << "#{key}=\"#{values[key]}\"" if values[key]
    end

    "OAuth #{buffer.join(', ')}"
  end

  def https_connection(path, authorization, post_data={})
    http = Net::HTTP.new('www.yammer.com', 443)
    http.use_ssl = true
    if post_data == :get
      request = Net::HTTP::Get.new(path)
    else
      request = Net::HTTP::Post.new(path)
      request.set_form_data(post_data, ';') if post_data.size > 0
    end
    request.add_field 'Authorization', authorization
    request.add_field 'Content-Type', 'application/x-www-form-urlencoded'
    request.add_field 'User-Agent', 'Ruby OAuth Example'

    response = http.request(request)
    response.body
  end

  def parse(raw_data)
    hash = {}
    raw_data.split('&').each do |key_value|
      key, value = key_value.split('=')
      hash[key] = value
    end
    hash
  end

  def run

    if ARGV[0] == 'request_token'
      pp parse(https_connection('/oauth/request_token', headers(nil, nil, nil)))
    elsif ARGV[0] == 'access_token'
      pp parse(https_connection('/oauth/access_token', headers(ARGV[1], ARGV[2], ARGV[3])))
    elsif ARGV[0] == 'messages'
      puts https_connection('/api/v1/messages.json', headers(ARGV[1], ARGV[2], nil), :get)
    elsif ARGV[0] == 'post'
      params = {'body' => 'test message'}
      puts https_connection('/api/v1/messages.json', headers(ARGV[1], ARGV[2], nil), params)
    end

  end
end

t = OAuthExample.new
t.run
