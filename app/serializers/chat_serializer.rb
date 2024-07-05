class ChatSerializer < ActiveModel::Serializer
  attributes :name, :number, :messages_count, :created_at, :updated_at
end

