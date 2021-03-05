# frozen_string_literal: true

require 'rest-client'
require 'json'

class GitHubClient
  def collect_user_details(username)
    uri = URI.parse("api.github.com/users/#{username}")
    responce = RestClient.get(uri.path)

    json_to_hash(responce)
  rescue RestClient::ExceptionWithResponse, JSON::ParserError
    false
  end

  private

  def json_to_hash(responce)
    return JSON.parse(responce, { symbolize_names: true }) if responce.code == 200

    false
  end
end
