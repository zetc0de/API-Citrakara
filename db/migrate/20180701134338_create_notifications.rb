class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :notif
      t.integer :user_id
      t.integer :painting_id

      t.timestamps
    end
  end
end
