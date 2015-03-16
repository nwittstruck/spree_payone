module Spree
  module Admin
    module PayoneSettingsHelper
      def payone_settings_globalize_select_values values
        values.each do |value|
          if value.is_a?(Array) && value.length > 0
            value[0] = t(value[0], scope: 'payone')
          end
        end
      end

      def payone_settings_preference_field_tag(name, value, options)
        case options[:type]
        when :boolean
          select_tag name,
            options_for_select([
              [Spree.t(:say_yes), 'true'],
              [Spree.t(:say_no), 'false']
            ], value.to_s),
            {class: 'select2'}
        when :string
          if options.has_key? :values
            values = payone_settings_globalize_select_values(options[:values])
            select_tag name,
              options_for_select(values, value.to_s),
              {class: 'select2'}
          else
            text_field_tag(name, value, preference_field_options(options))
          end
        else
          preference_field_tag(name, value, options)
        end
      end
    end
  end
end
