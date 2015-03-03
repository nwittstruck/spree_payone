class AddIbanToPayoneDebitPaymentPaymentSource < ActiveRecord::Migration
  def change
    add_column :spree_payone_debit_payment_payment_sources, :iban, :string
    add_column :spree_payone_debit_payment_payment_sources, :bic, :string
  end
end
