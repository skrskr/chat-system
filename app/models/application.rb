class Application < ApplicationRecord
    validates :name, presence: true

    has_many :chats
end
