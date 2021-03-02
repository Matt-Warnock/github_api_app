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

  private

  attr_reader :input, :output
end
