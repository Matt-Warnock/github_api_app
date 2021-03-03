# frozen_string_literal: true

require 'git_hub_retriever'

RSpec.describe GitHubRetriever do
  let(:user_details) { File.open('spec/fixtures/test.json').read }
  let(:retriever) { described_class.new }

  describe '#collect_user_details' do
    it 'sends a get request to the github usernames api address' do
      stub = ok_stub

      retriever.collect_user_details('Matt-Warnock')

      expect(stub).to have_been_requested
    end

    it 'returns a hash from the github api if status is 200' do
      user_details_hash = JSON.parse(user_details, { symbolize_names: true })
      ok_stub

      result = retriever.collect_user_details('Matt-Warnock')

      expect(result).to eq(user_details_hash)
    end

    it 'it does not try to return a hash if status is anything other than 200' do
      user_details_hash = JSON.parse(user_details, { symbolize_names: true })
      stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
        .to_return(status: 204)

      result = retriever.collect_user_details('Matt-Warnock')

      expect(result).to_not eq(user_details_hash)
    end
  end

  def ok_stub
    stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
      .to_return(status: 200, body: user_details)
  end
end
