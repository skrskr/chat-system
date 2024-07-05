class CreateMessageNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :message_numbers do |t|
      t.string :application_token, limit: 16
      t.integer :chat_number
      t.integer :number, default: 0

      t.timestamps
    end

    add_index :message_numbers, [:application_token, :chat_number], unique: true
  end
end
