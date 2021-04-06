# frozen_string_literal: true

require 'sinatra_presenter'

RSpec.describe SinatraPresenter do
  let(:ui) { described_class.new(input) }
  let(:input) { 'Matt-Warnock' }

  describe '#username_prompt' do
    it 'returns a prompt for user to enter a username' do
      expect(ui.username_prompt).to include('Enter a github username')
    end
  end

  describe '#ask_for_valid_username' do
    it 'updates error if username is invalid' do
      ui = described_class.new('-dsdr--fd')
      ui.ask_for_valid_username

      expect(ui.error).to be true
    end

    it 'returns valid github username from user' do
      result = ui.ask_for_valid_username

      expect(result).to eq('Matt-Warnock')
    end
  end

  describe '#handle_result' do
    context 'when successful' do
      it 'updates github_user' do
        ui.handle_result(github_data_hash)

        expect(ui.github_user).to eq(github_data_hash)
      end

      it 'does not update error' do
        ui.handle_result(github_data_hash)

        expect(ui.error).to be false
      end
    end

    context 'when unsuccessful' do
      it 'updates error' do
        ui.handle_result(false)

        expect(ui.error).to be true
      end

      it 'does not update github_user' do
        ui.handle_result(false)

        expect(ui.github_user).to be_empty
      end
    end
  end

  describe '#error_message' do
    it 'returns error message' do
      expect(ui.error_message).to eq('No such user!')
    end
  end
  describe '#another_username?' do
    it 'returns false' do
      result = ui.another_username?

      expect(result).to be(false)
    end
  end

  def github_data_hash
    {
      login: 'Matt Warnock',
      id: 1,
      avatar_url: 'https://avatars.githubusercontent.com/u/irelivent',
      html_url: 'https://github.com/Matt-Warnock'
    }
  end
end
