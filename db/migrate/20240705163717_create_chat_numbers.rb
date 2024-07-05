class CreateChatNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_numbers do |t|
      t.string :application_token, limit: 16
      t.integer :number, default: 0

      t.timestamps
    end

    add_index :chat_numbers, :application_token, unique: true
  end
end
