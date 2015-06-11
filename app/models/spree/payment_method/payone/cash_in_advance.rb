# Spree payment method which covers PAYONE cash in advance operations.
#
# Uses ::Spree::PaymentSource::Payone::PayoneCashInAdvancePaymentSource for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::Payone::CashInAdvance < PaymentMethod::Payone::PaymentMethod

    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::Payone::Provider::Payment::CashInAdvance
    end

    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::Payone::PayoneCashInAdvancePaymentSource
    end

    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_cashinadvance'
    end
  end
end
