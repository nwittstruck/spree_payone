module Spree
  module Admin
    class PayoneSettingsController < BaseController
      def init_preferences
        @connection_preferences = {
          payone_merchant_id: {},
          payone_payment_portal_id: {},
          payone_payment_portal_key: {},
          payone_sub_account_id: {},
          payone_test_mode: {}
        }

        @redirect_url_preferences = {
          payone_engine_host: {}
        }

        @logging_preferences = {
          payone_db_logging_enabled: {},
          payone_file_logging_enabled: {}
        }

        @validation_preferences = {
          payone_billing_address_validation_type: {
            values: [
              [Spree::Payone::Utils::AddressValidationType::NONE_SYMBOL, Spree::Payone::Utils::AddressValidationType::NONE],
              [Spree::Payone::Utils::AddressValidationType::ADDRESSCHECK_SYMBOL, Spree::Payone::Utils::AddressValidationType::ADDRESSCHECK],
              [Spree::Payone::Utils::AddressValidationType::CONSUMERSCORE_SYMBOL, Spree::Payone::Utils::AddressValidationType::CONSUMERSCORE]]
          },
          payone_shipping_address_validation_type: {
            values: [
              [Spree::Payone::Utils::AddressValidationType::NONE_SYMBOL, Spree::Payone::Utils::AddressValidationType::NONE],
              [Spree::Payone::Utils::AddressValidationType::ADDRESSCHECK_SYMBOL, Spree::Payone::Utils::AddressValidationType::ADDRESSCHECK]]
          }
        }

        @address_validation_preferences = {
          payone_billing_address_address_check_address_check_type: {
            values: [
              [Spree::Payone::Utils::AddressCheckType::BASIC_SYMBOL, Spree::Payone::Utils::AddressCheckType::BASIC],
              [Spree::Payone::Utils::AddressCheckType::PERSON_SYMBOL, Spree::Payone::Utils::AddressCheckType::PERSON]]
          },
          payone_billing_address_consumer_score_address_check_type: {
            values: [
              [Spree::Payone::Utils::AddressCheckType::BASIC_SYMBOL, Spree::Payone::Utils::AddressCheckType::BASIC],
              [Spree::Payone::Utils::AddressCheckType::PERSON_SYMBOL, Spree::Payone::Utils::AddressCheckType::PERSON],
              [Spree::Payone::Utils::AddressCheckType::NO_SYMBOL, Spree::Payone::Utils::AddressCheckType::NO]]
          },
          payone_billing_address_consumer_score_consumer_score_type: {
            values: [
              [Spree::Payone::Utils::ConsumerScoreType::IH_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IH],
              [Spree::Payone::Utils::ConsumerScoreType::IA_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IA],
              [Spree::Payone::Utils::ConsumerScoreType::IB_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IB]]
          },
          payone_shipping_address_address_check_address_check_type: {
            values: [
              [Spree::Payone::Utils::AddressCheckType::BASIC_SYMBOL, Spree::Payone::Utils::AddressCheckType::BASIC],
              [Spree::Payone::Utils::AddressCheckType::PERSON_SYMBOL, Spree::Payone::Utils::AddressCheckType::PERSON]]
          },
          payone_shipping_address_consumer_score_address_check_type: {
            values: [
              [Spree::Payone::Utils::AddressCheckType::BASIC_SYMBOL, Spree::Payone::Utils::AddressCheckType::BASIC],
              [Spree::Payone::Utils::AddressCheckType::PERSON_SYMBOL, Spree::Payone::Utils::AddressCheckType::PERSON],
              [Spree::Payone::Utils::AddressCheckType::NO_SYMBOL, Spree::Payone::Utils::AddressCheckType::NO]]
          },
          payone_shipping_address_consumer_score_consumer_score_type: {
            values: [
              [Spree::Payone::Utils::ConsumerScoreType::IH_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IH],
              [Spree::Payone::Utils::ConsumerScoreType::IA_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IA],
              [Spree::Payone::Utils::ConsumerScoreType::IB_SYMBOL, Spree::Payone::Utils::ConsumerScoreType::IB]]
          }
        }

        @address_check_validation_preferences = {
          payone_address_check_none_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_ppb_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_phb_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_pab_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_pki_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_pnz_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_ppv_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          },
          payone_address_check_ppf_person_status_to_consumer_score_score_mapping: {
            values: [
              [Spree::Payone::Utils::Score::GREEN_SYMBOL, Spree::Payone::Utils::Score::GREEN],
              [Spree::Payone::Utils::Score::YELLOW_SYMBOL, Spree::Payone::Utils::Score::YELLOW],
              [Spree::Payone::Utils::Score::RED_SYMBOL, Spree::Payone::Utils::Score::RED]]
          }
        }

        @consumer_score_validation_preferences = {
          payone_consumer_score_on_yellow_score_allow_total_under: {},
          payone_consumer_score_on_yellow_score_block_total_over: {},
          payone_consumer_score_on_yellow_score_gateway_payone_credit_card_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_online_bank_transfer_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_debit_payment_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_e_wallet_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_cash_on_delivery_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_cash_in_advance_enabled: {},
          payone_consumer_score_on_yellow_score_payment_method_payone_invoice_enabled: {}
        }
      end

      def edit
        init_preferences
      end

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        redirect_to edit_admin_payone_settings_path
      end

      def dismiss_alert
        if request.xhr? and params[:alert_id]
          dismissed = Spree::Config[:dismissed_spree_alerts] || ''
          Spree::Config.set dismissed_spree_alerts: dismissed.split(',').push(params[:alert_id]).join(',')
          filter_dismissed_alerts
          render nothing: true
        end
      end
    end
  end
end
