require 'json'

class MessageCreationJob
  include Sidekiq::Job
  sidekiq_options :queue => :message_creation, :retry => 3

  def perform(chat_id, number, body)
    puts("Message Creation Job")
    chat = Chat.find_by(id: chat_id)
    message = Message.new()
    message.body = body
    message.chat = chat
    message.number = number
    message.save
    puts("Message Created")    
  end
end
