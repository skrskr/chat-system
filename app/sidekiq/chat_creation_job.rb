class ChatCreationJob
  include Sidekiq::Job

  def perform(chat_params, application_token, number)
    puts("Chat Creation Job")
    puts(chat_params)
    @application = Application.find_by(token: application_token)
    @chat = Chat.new()
    @chat.name = chat_params["name"]
    @chat.application = @application
    @chat.number = number
    @chat.save

    puts("Chat Created")
  end
end
