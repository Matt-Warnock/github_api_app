# frozen_string_literal: true

require 'git_hub_retriever'

RSpec.describe GitHubRetriever do
  let(:user_details) { File.open('spec/fixtures/test.json').read }
  let(:retriever) { described_class.new }

  describe '#collect_user_details' do
    it 'sends a get request to the github usernames api address' do
      stub = stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
             .to_return(status: 200, body: user_details)

      retriever.collect_user_details('Matt-Warnock')

      expect(stub).to have_been_requested
    end
  end
end
