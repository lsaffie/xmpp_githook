class PushWireProtocol
  def self.parse_post(post)
    json = JSON.parse(post)
    commit = json["commits"][0]
    repo = json["repository"]
    string = "#{commit['author']['name']} commited to #{repo['name']}. #{commit['message']}"
    string
  end
end
