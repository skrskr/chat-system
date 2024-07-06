
class SearchMessageSerializer < ActiveModel::Serializer
  type 'messages'
  attributes :body, :number, :created_at, :updated_at

  attribute :body do
    object[:_source][:body]
  end
  
  attribute :created_at do
    object[:_source][:created_at]
  end

  attribute :updated_at do
    object[:_source][:updated_at]
  end

  attribute :number do
    object[:_source][:number]
  end
end
