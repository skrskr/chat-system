class ChatCreationJob
  include Sidekiq::Job

  def perform(application_id, name, number)
    puts("Chat Creation Job")
    application = Application.find_by!(id: application_id)
    chat = Chat.new()
    chat.name = name
    chat.application = application
    chat.number = number
    chat.save

    puts("Chat Created")
  end
end
