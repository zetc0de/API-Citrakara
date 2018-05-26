class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :artist,default: false
      t.boolean :admin,default: false
      t.string :bio
      t.string :telp

      t.timestamps
    end
  end
end
