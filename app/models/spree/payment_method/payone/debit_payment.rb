# Spree payment method which covers PAYONE debit payment operations.
#
# Uses ::Spree::PaymentSource::Payone::DebitPayment for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::Payone::DebitPayment < PaymentMethod::Payone::PaymentMethod

    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::Payone::Provider::Payment::DebitPayment
    end

    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::Payone::PayoneDebitPaymentPaymentSource
    end

    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_debitpayment'
    end
  end
end
