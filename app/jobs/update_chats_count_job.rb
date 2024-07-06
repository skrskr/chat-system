class UpdateChatsCountJob
  include Sidekiq::Worker
  sidekiq_options :queue => :counter
  
  def perform
    puts("Update Chats Count Job")
    Application.includes(:chats).find_each do |application|
      application.update(chats_count: application.chats.size)
    end
    puts("Chats Count Updated")
  end
end