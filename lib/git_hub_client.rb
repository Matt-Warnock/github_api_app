# frozen_string_literal: true

require 'rest-client'

class GitHubClient
  def collect_user_details(username)
    uri = URI.parse("api.github.com/users/#{username}")

    RestClient.get(uri.path) do |responce|
      return json_to_hash(responce.body) if responce.code == 200

      false
    end
  end

  def json_to_hash(responce)
    JSON.parse(responce, { symbolize_names: true })
  rescue JSON::ParserError
    false
  end
end
