# frozen_string_literal: true

require 'user_interface'

RSpec.describe UserInterface do
  let(:ui) { described_class.new(input, output) }
  let(:input) { StringIO.new("Matt-Warnock\n") }
  let(:output) { StringIO.new }

  describe '#ask_for_valid_username' do
    it 'asks user for github username' do
      ui.ask_for_valid_username

      expect(output.string).to include('Please enter a github username: ')
    end

    it 'collects valid github username from user' do
      result = ui.ask_for_valid_username

      expect(result).to eq('Matt-Warnock')
    end

    it 'prints error message if username is invaild' do
      input = StringIO.new("-mattwarnock\nmatt-warnock\n")
      ui = described_class.new(input, output)

      ui.ask_for_valid_username

      expect(output.string).to include('Invalid Git-Hub username')
    end

    it 'keeps asking user for input untill a valid username is given' do
      input = StringIO.new("matt--warnock\nmatt-warnock\n")
      ui = described_class.new(input, output)

      ui.ask_for_valid_username

      expect(output.string.scan('Please enter').length).to eq(2)
    end
  end

  describe 'display_github_info' do
    it 'prints users github information' do
      github_data_hash = {
        name: 'Matt Warnock',
        id: 1,
        avatar_url: 'https://avatars.githubusercontent.com/u/irelivent',
        html_url: 'https://github.com/Matt-Warnock'
      }

      ui.display_github_info(github_data_hash)

      expect(output.string).to include('Matt Warnock is GitHub user #1
Avatar: https://avatars.githubusercontent.com/u/irelivent
Link to profile: https://github.com/Matt-Warnock')
    end
  end
end
