class CreateFavoritePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_paintings do |t|
      t.integer :painting_id
      t.integer :user_id

      t.timestamps
    end
  end
end
