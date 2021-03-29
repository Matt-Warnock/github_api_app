# frozen_string_literal: true

class SinatraPresenter
  USERNAME_REGEX = /^\w(?:\w|-(?=\w)){0,38}$/i.freeze

  attr_reader :error, :github_user

  def initialize(input = nil)
    @input = input
    @error = false
    @github_user = {}
  end

  def username_prompt
    'Enter a github username <span class="valid-message">(only valid github usernames are accepted)</span>:'
  end

  def ask_for_valid_username
    @error = true unless @input.match?(USERNAME_REGEX)
    @input
  end

  def handle_result(responce)
    if responce
      @github_user = responce
    else
      @error = true
    end
  end

  def error_message
    'No such user!'
  end

  def another_username?
    false
  end
end
