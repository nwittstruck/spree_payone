# Spree payment method which covers PAYONE e-wallet operations.
#
# Uses ::Spree::PaymentSource::Payone::EWallet for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::Payone::EWallet < PaymentMethod::Payone::PaymentMethod

    # Payment method preferences
    preference :wallet_type, :string, :default => 'PPE'

    # Returns true if confirmation needed before processing the payment.
    def payment_confirmation_required?
      true
    end

    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::Payone::Provider::Payment::EWallet
    end

    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::Payone::PayoneEWalletPaymentSource
    end

    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_ewallet'
    end
  end
end
