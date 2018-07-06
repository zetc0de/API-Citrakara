class RemoveBuktiTransferFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :buktitransfer, :string
  end
end
