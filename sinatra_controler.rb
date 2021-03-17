# frozen_string_literal: true

require 'sinatra'

require_relative 'lib/git_hub_client'
require_relative 'lib/user_info_retriever'
require_relative 'lib/sinatra_interface'

get '/' do
  @prompt = 'enter a github username'
  erb :index
end

post '/search' do
  input = params['username']
  output = {}

  sinatra_interface = SinatraInterface.new(input, output)
  UserInfoRetriever.new(sinatra_interface, GitHubClient.new).run

  @results = output[:github_data]
  @error_message = output[:error_message]

  erb :result
end
