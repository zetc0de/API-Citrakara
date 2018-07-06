class AddBuktiToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :bukti, :string
  end
end
