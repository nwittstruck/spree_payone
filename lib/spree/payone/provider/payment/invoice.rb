# Provides implementation for Spree payment process logic for Spree::PaymentMethod::Payone::Invoice
module Spree::Payone
  module Provider
    module Payment
      class Invoice < Spree::Payone::Provider::Payment::Base

        # Sets initial data.
        def initialize(options)
          super(options)
          @shipping_provider = options[:shipping_provider]
        end

        # Proceses payment method authorize action.
        def authorize(money, invoice_source, payment_method_options = {})
          Spree::Payone::Logger.info "Authorize process started"

          request = Spree::Payone::Proxy::Request.new
          request.preauthorization_request

          set_initial_request_parameters(request)
          set_invoice_request_parameters(request, invoice_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)

          response = process_request request, payment_method_options
          payment_provider_response response
        end

        # Proceses gateway purchase action.
        def purchase(money, invoice_source, payment_method_options = {})
          Spree::Payone::Logger.info "Purchase process started"

          request = Spree::Payone::Proxy::Request.new
          request.authorization_request

          set_initial_request_parameters(request)
          set_invoice_request_parameters(request, invoice_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)

          response = process_request request, payment_method_options
          payment_provider_response response
        end

        # Proceses gateway capture action.
        def capture(money, response_code, payment_method_options = {})
          Spree::Payone::Logger.info "Capture process started"

          request = Spree::Payone::Proxy::Request.new
          request.capture_request

          set_initial_request_parameters(request)
          set_amount_request_parameters(request, money, payment_method_options)
          set_payment_process_parameters(request, response_code)

          response = process_request request, payment_method_options
          payment_provider_response response
        end

        # Proceses gateway void action.
        def void(response_code, provider_source, gateway_options = {})
          Spree::Payone::Logger.info "Void process started"
          payment_payment_provider_successful_response
        end

        # Proceses gateway credit action.
        def credit(money, response_code, gateway_options = {})
          Spree::Payone::Logger.info "Credit process started"

          request = Spree::Payone::Proxy::Request.new
          request.debit_request
          set_initial_request_parameters(request)
          set_amount_request_parameters(request, '-' + money.to_s, gateway_options)
          set_payment_process_parameters(request, response_code)
          set_sequence_request_parameters(request, response_code)

          response = process_request request, payment_method_options
          payment_provider_response response
        end

        # Sets invoice parameters.
        def set_invoice_request_parameters(request, invoice_source)
          request.invoice_clearingtype
        end
      end
    end
  end
end
