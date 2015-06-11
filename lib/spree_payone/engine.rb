module SpreePayone
  class Engine < Rails::Engine
    engine_name 'spree_payone'

    initializer "spree_payone.register.payment_methods", after: 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods += [
        Spree::Gateway::Payone::CreditCard,
        Spree::PaymentMethod::Payone::OnlineBankTransfer,
        Spree::PaymentMethod::Payone::DebitPayment,
        Spree::PaymentMethod::Payone::EWallet,
        Spree::PaymentMethod::Payone::CashOnDelivery,
        Spree::PaymentMethod::Payone::CashInAdvance,
        Spree::PaymentMethod::Payone::Invoice
      ]
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths += %W(#{config.root}/lib)

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Deface::Override.new(
        virtual_path:  "spree/layouts/admin",
        insert_bottom: "#main-sidebar",
        partial:       "spree/payone/admin/shared/payone_tab",
        name:          "payone_extension_menu_tab",
        original:      "82da3a16506fbf9567b0f2623bd56cd234473735")
    end
  end
end
