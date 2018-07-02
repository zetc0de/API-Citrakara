class CreateHighlights < ActiveRecord::Migration[5.2]
  def change
    create_table :highlights do |t|
      t.datetime :expire_date
      t.boolean :expired
      t.references :user, foreign_key: true
      t.references :painting, foreign_key: true

      t.timestamps
    end
  end
end
