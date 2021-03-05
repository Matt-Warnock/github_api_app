# frozen_string_literal: true

class UserInfoRetriever
  def initialize(user_interface, client)
    @user_interface = user_interface
    @client = client
  end

  def run
    loop do
      username = user_interface.ask_for_valid_username
      responce = client.collect_user_details(username)

      handle_result(responce)
      break unless user_interface.another_username?
    end
  end

  private

  def handle_result(responce)
    return user_interface.display_github_info(responce) if responce

    user_interface.error_message
  end

  attr_reader :user_interface, :client
end
