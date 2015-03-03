module Spree
  CheckoutController.class_eval do

    def payone_success
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]

      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :success_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first

          if payment.response_code == request_history_entry.txid
            if request_history_entry.request_type == "authorization"
              payment.complete!
            else
              payment.pend!
            end
            request_history_entry.overall_status = true
            request_history_entry.save

            # Process complete order step
            unless @order.state == "complete" || @order.completed?
              # We must process changes manually
              @order.state= :complete
              @order.finalize!
              @order.update!
              state_callback(:after)
            end

            flash.notice = t(:order_processed_successfully)
            redirect_to completion_route and return
          end
        end
      end

      # Redirect to error if not handled already
      flash[:error] = t(:payment_processing_failed)
      respond_with(@order, :location => checkout_state_path(@order.state))
      return
    end

    def payone_error
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]

      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :error_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first

          if payment.response_code == request_history_entry.txid
            payment.failure
          end
        end
      end

      @order.state = 'payment'
      @order.save

      flash[:error] = t(:payment_processing_failed)
      respond_with(@order) { |format| format.html { render :edit } }
    end

    def payone_back
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]

      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :back_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first

          if payment.response_code == request_history_entry.txid
            payment.failure
          end
        end
      end

      @order.state = 'payment'
      @order.save

      flash[:error] = t(:payment_processing_canceled)
      respond_with(@order) { |format| format.html { render :edit } }
    end

    def permitted_source_attributes
      super + [
        :iban,
        :bic,
        :bank_country,
        :first_name,
        :last_name,
        :bank_account_holder
      ]
    end
  end
end
