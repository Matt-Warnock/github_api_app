# frozen_string_literal: true

require 'git_hub_client'

RSpec.describe GitHubClient do
  let(:user_details) { File.open('spec/fixtures/test.json').read }
  let(:client) { described_class.new }

  describe '#collect_user_details' do
    it 'sends a get request to the github usernames api address' do
      stub = ok_stub

      client.collect_user_details('Matt-Warnock')

      expect(stub).to have_been_requested
    end

    it 'returns a hash from the github api if status is 200' do
      user_details_hash = JSON.parse(user_details, { symbolize_names: true })
      ok_stub

      result = client.collect_user_details('Matt-Warnock')

      expect(result).to eq(user_details_hash)
    end

    it 'returns false if status is anything other than 200' do
      stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
        .to_return(status: 206, body: user_details)

      result = client.collect_user_details('Matt-Warnock')

      expect(result).to eq(false)
    end

    it 'does not raise an error when request timesout' do
      stub_request(:get, 'http://api.github.com/users/irelevent')
        .to_timeout

      expect { client.collect_user_details('irelevent') }.not_to raise_error
    end

    it 'does not raise an error when responce fails' do
      stub_request(:get, 'http://api.github.com/users/irelevent')
        .to_raise(RestClient::ExceptionWithResponse)

      expect { client.collect_user_details('irelevent') }.not_to raise_error
    end

    it 'returns false when request has failed' do
      stub_request(:get, 'http://api.github.com/users/irelevent')
        .to_return(status: 408)

      result = client.collect_user_details('irelevent')

      expect(result).to be(false)
    end

    it 'does not raise an error when body is invalid json' do
      stub_request(:get, 'http://api.github.com/users/irelevent')
        .to_return(status: 200, body: "{ name: 'harry' }")

      expect { client.collect_user_details('irelevent') }.not_to raise_error
    end

    it 'returns false when body is invalid json' do
      stub_request(:get, 'http://api.github.com/users/irelevent')
        .to_return(status: 200, body: ':-')

      result = client.collect_user_details('irelevent')

      expect(result).to be(false)
    end
  end

  def ok_stub
    stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
      .to_return(status: 200, body: user_details)
  end
end
