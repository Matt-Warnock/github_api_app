# frozen_string_literal: true

require 'rest-client'

class GitHubClient
  def collect_user_details(username)
    uri = URI.parse("api.github.com/users/#{username}")
    responce = RestClient.get(uri.path)

    JSON.parse(responce, { symbolize_names: true }) if responce.code == 200
  end
end
