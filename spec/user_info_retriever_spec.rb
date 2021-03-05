# frozen_string_literal: true

require 'git_hub_client'
require 'user_info_retriever'
require 'user_interface'

RSpec.describe UserInfoRetriever do
  let(:user_info) { File.open('spec/fixtures/test.json').read }
  let(:output) { StringIO.new }

  describe '#run' do
    it 'asks the user for github username' do
      ok_stub

      run_retriever

      expect(output.string).to include('Please enter a github username: ')
    end

    it 'sends a request to github' do
      stub = ok_stub

      run_retriever

      expect(stub).to have_been_requested
    end

    it 'prints user details if received ok' do
      ok_stub

      run_retriever

      expect(output.string).to include('Matt-Warnock is GitHub user #60718290
Avatar: https://avatars.githubusercontent.com/u/60718290?v=4
Link to profile: https://github.com/Matt-Warnock')
    end

    it 'prints error message if not received ok' do
      stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
        .to_return(status: 404)

      run_retriever

      expect(output.string).to include('No such user!')
    end

    it 'asks user if they want to enter another username' do
      ok_stub

      run_retriever

      expect(output.string).to include('another username[y/n]?: ')
    end

    it 'asks user again for a username if they choose yes' do
      input = StringIO.new("Matt-Warnock\ny\nMatt-Warnock\nn\n")
      ui = UserInterface.new(input, output)
      retriever = described_class.new(ui, GitHubClient.new)
      ok_stub

      retriever.run

      expect(output.string.scan('enter a github username').length).to eq(2)
    end
  end

  def ok_stub
    stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
      .to_return(status: 200, body: user_info)
  end

  def run_retriever
    input = StringIO.new("Matt-Warnock\nn\n")
    ui = UserInterface.new(input, output)
    retriever = described_class.new(ui, GitHubClient.new)

    retriever.run
  end
end
