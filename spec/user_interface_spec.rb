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

      expect(output.string).to include('Invalid input')
    end

    it 'keeps asking user for input until a valid username is given' do
      input = StringIO.new("matt--warnock\nmatt-warnock\n")
      ui = described_class.new(input, output)

      ui.ask_for_valid_username

      expect(output.string.scan('Please enter').length).to eq(2)
    end
  end

  describe '#handle_result' do
    it 'displays the github info if a truthy objected is passed' do
      ui.handle_result(github_data_hash)

      expect(output.string).to include('Matt Warnock is GitHub user #1
Avatar: https://avatars.githubusercontent.com/u/irelivent
Link to profile: https://github.com/Matt-Warnock')
    end

    it 'displays error message if a falsy object is passed' do
      ui.handle_result(false)

      expect(output.string).to include('No such user!')
    end
  end

  describe '#display_github_info' do
    it 'prints users github information' do
      ui.display_github_info(github_data_hash)

      expect(output.string).to include('Matt Warnock is GitHub user #1
Avatar: https://avatars.githubusercontent.com/u/irelivent
Link to profile: https://github.com/Matt-Warnock')
    end
  end

  describe '#error_message' do
    it 'prints error message' do
      ui.error_message

      expect(output.string).to include('No such user!')
    end
  end
  describe '#another_username?' do
    it 'asks user if they want to enter another github username' do
      input = StringIO.new("y\n")
      ui = described_class.new(input, output)

      ui.another_username?

      expect(output.string).to include('Would you like to enter another username[y/n]?: ')
    end

    it 'prints error message if answer is invaild' do
      input = StringIO.new("good show!\nn\n")
      ui = described_class.new(input, output)

      ui.another_username?

      expect(output.string).to include('Invalid input')
    end

    it 'keeps asking user for input until a valid answer is given' do
      input = StringIO.new("whhaa\ny\n")
      ui = described_class.new(input, output)

      ui.another_username?

      expect(output.string.scan('another username[y/n]?').length).to eq(2)
    end

    it 'returns true if answer is y' do
      input = StringIO.new("y\n")
      ui = described_class.new(input, output)

      result = ui.another_username?

      expect(result).to be(true)
    end

    it 'case insensitive, returns true if answer is Y' do
      input = StringIO.new("Y\n")
      ui = described_class.new(input, output)

      result = ui.another_username?

      expect(result).to be(true)
    end

    it 'returns false if answer is n' do
      input = StringIO.new("n\n")
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
