class AddActionbyToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :actionby, :integer
  end
end
