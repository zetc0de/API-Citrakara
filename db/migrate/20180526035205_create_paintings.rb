class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :title
      t.text :description
      t.string :imagepath

      t.timestamps
    end
  end
end
