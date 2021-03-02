# frozen_string_literal: true

class UserInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def ask_for_valid_username
    loop do
      output.print 'Please enter a github username: '
      username = input.gets.chomp
      break username if username.match?(/^[\w](?:[\w]|-(?=[\w])){0,38}$/i)

      output.print "Invalid Git-Hub username\n"
    end
  end

  def display_github_info(hash)
    output.print "#{hash[:name]} is GitHub user ##{hash[:id]}
Avatar: #{hash[:avatar_url]}
Link to profile: #{hash[:html_url]}"
  end

  private

  attr_reader :input, :output
end
