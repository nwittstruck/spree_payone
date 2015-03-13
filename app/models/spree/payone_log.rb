# Provides PAYONE LOG model. It is used to store logs.
module Spree
  class PayoneLog < ActiveRecord::Base
    # we must run logger within new connection to avoid changes to be rollbacked
    # for details see: state_machine documentation
    establish_connection Rails.env.to_sym

    def self.log_levels
      self.uniq.order('level ASC').pluck(:level)
    end
  end
end
