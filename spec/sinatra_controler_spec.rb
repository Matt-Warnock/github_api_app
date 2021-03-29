# frozen_string_literal: true

require_relative '../sinatra_controler'

RSpec.describe 'sinatra_controler' do
  def app
    SinatraControler
  end

  describe '/' do
    before { get '/' }
    it 'is succesful' do
      expect(last_response).to be_ok
    end

    it 'displays username prompt' do
      expect(last_response.body).to include('Enter a github username')
    end
  end

  describe '/search' do
    let(:user_details) { File.open('spec/fixtures/test.json').read }

    it 'is succesful' do
      ok_setup_with_stub
      expect(last_response).to be_ok
    end

    it 'redirects if username was invalid' do
      post '/search', username: '-EDKS--wld'

      expect(last_response.redirect?).to be true
    end

    it 'displays results if search was succesful' do
      ok_setup_with_stub
      expect(last_response.body).to match(
        %r{<img src="https://avatars.githubusercontent.com/u/60718290\?v=4" alt="avatar img">
\s+</div>
\s+<a href="https://github.com/Matt-Warnock">Link to profile</a>
\s+<p class="typed">Matt-Warnock is GitHub user 60718290}
      )
    end

    it 'displays error message if error has been called' do
      stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
        .to_return(status: 404)
      post '/search', username: 'Matt-Warnock'

      expect(last_response.body).to include('No such user!')
    end

    def ok_setup_with_stub
      stub_request(:get, 'http://api.github.com/users/Matt-Warnock')
        .to_return(status: 200, body: user_details)
      post '/search', username: 'Matt-Warnock'
    end
  end
end
