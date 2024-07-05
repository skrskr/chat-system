class Chat < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :application
  has_many :messages
end
