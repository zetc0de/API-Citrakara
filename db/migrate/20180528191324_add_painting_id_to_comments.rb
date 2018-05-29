class AddPaintingIdToComments < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :painting_id, :integer
    add_index  :comments, :painting_id
  end
end
