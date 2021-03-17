# frozen_string_literal: true

require 'sinatra_interface'

RSpec.describe SinatraInterface do
  let(:ui) { described_class.new(input, output) }
  let(:input) { 'Matt-Warnock' }
  let(:output) { { github_data: nil, error_message: nil } }

  describe '#ask_for_valid_username' do
    it 'collects valid github username from user' do
      result = ui.ask_for_valid_username

      expect(result).to eq('Matt-Warnock')
    end
  end

  describe 'display_github_info' do
    it 'sends users github information to output hash' do
      ui.display_github_info(github_data_hash)

      expect(output[:github_data]).to eq(github_data_hash)
    end
  end

  describe '#error_message' do
    it 'sends error message to output hash' do
      ui.error_message

      expect(output[:error_message]).to eq('No such user!')
    end
  end
  describe '#another_username?' do
    it 'returns false' do
      ui = described_class.new(input, output)

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
