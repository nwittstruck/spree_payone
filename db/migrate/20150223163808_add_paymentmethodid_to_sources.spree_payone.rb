class AddPaymentmethodidToSources < ActiveRecord::Migration
  def change
    add_column :spree_payone_online_bank_transfer_payment_sources, :payment_method_id, :integer
    add_column :spree_payone_debit_payment_payment_sources, :payment_method_id, :integer
    add_column :spree_payone_e_wallet_payment_sources, :payment_method_id, :integer
    add_column :spree_payone_cash_on_delivery_payment_sources, :payment_method_id, :integer
    add_column :spree_payone_cash_in_advance_payment_sources, :payment_method_id, :integer
    add_column :spree_payone_invoice_payment_sources, :payment_method_id, :integer
  end
end
