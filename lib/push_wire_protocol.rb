class PushWireProtocol
  def self.parse_post(post)
    json = JSON.parse(post)
    commit = json["commits"][0]
    repo = json["repository"]
    string = "#commit #{commit['author']['name']} commited to #{repo['name']}. #{commit['message']}. #{commit['url']}"
    string
  end
end
