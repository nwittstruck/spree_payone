module Spree
  CreditCard.class_eval do

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      if payment.payment_method.is_a?(Spree::Gateway::Payone::CreditCard)
        return payment.state != 'void' && payment.state != 'completed' && payment.state != 'failed' && payment.state != 'processing'
      end
      return payment.state != 'void'
    end

    # Indicates whether its possible to credit the payment.
    def can_credit?(payment)
      return false if payment.payment_method.is_a?(Spree::Gateway::Payone::CreditCard)
      return false unless payment.state == 'completed'
      return false unless payment.order.payment_state == 'credit_owed'
      payment.credit_allowed > 0
    end
  end
end
