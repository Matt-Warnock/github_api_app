# frozen_string_literal: true

class UserInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def ask_for_valid_username
    prompt_valid_input('Please enter a github username: ', /^[\w](?:[\w]|-(?=[\w])){0,38}$/i)
  end

  def handle_result(responce)
    return display_github_info(responce) if responce

    error_message
  end

  def display_github_info(hash)
    output.print "\n#{hash[:login]} is GitHub user ##{hash[:id]}
Avatar: #{hash[:avatar_url]}
Link to profile: #{hash[:html_url]}\n\n"
  end

  def error_message
    output.print "No such user!\n"
  end

  def another_username?
    answer = prompt_valid_input('Would you like to enter another username[y/n]?: ', /[y|n]/i)
    answer.downcase == 'y'
  end

  private

  def prompt_valid_input(prompt, regex)
    loop do
      output.print prompt
      username = input.gets.chomp
      break username if username.match?(regex)

      output.print 'Invalid input '
    end
  end

  attr_reader :input, :output
end
