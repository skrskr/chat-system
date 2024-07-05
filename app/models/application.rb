class Application < ApplicationRecord
    after_create :create_chat_number
    
    validates :name, presence: true

    has_many :chats

    def create_chat_number
        ChatNumber.create!(application_token: self.token, number: 0)
    end
end
