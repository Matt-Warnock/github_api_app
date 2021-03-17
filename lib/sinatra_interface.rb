# frozen_string_literal: true

class SinatraInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def ask_for_valid_username
    @input
  end

  def display_github_info(hash)
    @output[:github_data] = hash
  end

  def error_message
    @output[:error_message] = 'No such user!'
  end

  def another_username?
    false
  end
end
