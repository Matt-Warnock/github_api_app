# frozen_string_literal: true

require 'sinatra'

require_relative 'lib/git_hub_client'
require_relative 'lib/user_info_retriever'
require_relative 'lib/sinatra_presenter'

class SinatraControler < Sinatra::Base
  set :port, ENV['PORT'] || 4567

  get '/' do
    @page = SinatraPresenter.new

    erb :index
  end

  post '/search' do
    @page = SinatraPresenter.new(params['username'])
    @page.ask_for_valid_username

    pass unless @page.error

    redirect '/'
  end

  post '/search' do
    @page = SinatraPresenter.new(params['username'])

    UserInfoRetriever.new(@page, GitHubClient.new).run

    if @page.error
      erb :error
    else
      erb :result
    end
  end
end
