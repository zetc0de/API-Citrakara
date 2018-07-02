class ChangeColumnConfirmedFromTransactions < ActiveRecord::Migration[5.2]
  def change
  	change_column :transactions, :confirmed, :boolean, default: false
  end
end
