# frozen_string_literal: true

require 'rest-client'

class GitHubRetriever
  def collect_user_details(username)
    uri = URI.parse("api.github.com/users/#{username}")
    RestClient.get(uri.path)
  end
end
