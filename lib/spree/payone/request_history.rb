# Provides simple request history functionallity based on PAYONE request history entries.
module Spree::Payone
  class RequestHistory
    include Singleton

    # Logs request history entry.
    def entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id = nil
      timestamp = Time.now.utc.to_s
      overall_status = overall_status ? 't' : 'f'
      # New connection retrieval moved to PayoneRequestHistory definition
      ::Spree::PayoneRequestHistoryEntry.create(
        txid: txid.to_s,
        request_type: request_type.to_s,
        status: status.to_s,
        overall_status: overall_status,
        success_token: success_token,
        back_token: back_token,
        error_token: error_token,
        payment_id: payment_id)
    end

    # Counts requests with successful overal status with specified txid.
    def count_overall_status_by_txid txid
      ::Spree::PayoneRequestHistoryEntry.where(:txid => txid.to_s, :overall_status => true).count
    end

    def self.entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id = nil
      Spree::Payone::RequestHistory.instance.entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id
    end

    def self.count_overall_status_by_txid txid
      Spree::Payone::RequestHistory.instance.count_overall_status_by_txid txid
    end
  end
end
