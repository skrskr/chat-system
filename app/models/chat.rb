class Chat < ApplicationRecord
  belongs_to :application
  validates :name, presence: true
end
