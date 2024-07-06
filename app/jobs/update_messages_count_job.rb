class UpdateMessagesCountJob
  include Sidekiq::Worker
  
  def perform
    puts("Update Messages Count Job")
    Chat.includes(:messages).find_each do |chat|
      chat.update(messages_count: chat.messages.size)
    end
    puts("Messages Count Updated")
  end
end