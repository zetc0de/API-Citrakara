class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :username
      t.text :pesan

      t.timestamps
    end
  end
end
