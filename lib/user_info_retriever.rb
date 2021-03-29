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

      user_interface.handle_result(responce)
      break unless user_interface.another_username?
    end
  end

  private

  attr_reader :user_interface, :client
end
