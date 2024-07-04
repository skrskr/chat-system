class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token, null: false, limit: 16

      t.timestamps
    end

    add_index :applications, :token, unique: true
  end
end
