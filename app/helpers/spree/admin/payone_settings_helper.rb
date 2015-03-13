module Spree
  module Admin
    module PayoneSettingsHelper
      def payone_settings_globalize_select_values values
        values.length.times do |i|
          if values[i].kind_of?(Array) && values[i].length > 0
            values[i][0] = t(values[i][0].to_s)
          end
        end
        values
      end

      def payone_settings_preference_field_tag(name, value, options)
        case options[:type]
        when :boolean
          select_tag name,
            options_for_select([[t(:yes, scope: 'payone'), 'true'], [t(:no, scope: 'payone'), 'false']], value.to_s),
            {size: 1, class: 'select2'}
        when :string
          if options.has_key? :values
            values = payone_settings_globalize_select_values(options[:values])
            select_tag name,
              options_for_select(values, value.to_s),
              {size: 1, class: 'select2', onchange: options[:onchange]}
          else
            text_field_tag(name, value, preference_field_options(options))
          end
        else
          preference_field_tag(name, value, options)
        end
      end

      def payone_settings_preference_visible_value(value, options)
        case options[:type]
        when :boolean
          value = value ? t(:yes, scope: 'payone') : t(:no, scope: 'payone')
        when :string
          if options.has_key? :values
            options[:values].each do |element|
              if element.kind_of?(Array) && element.length > 1 && element[1].to_s == value.to_s
                value = t(element[0])
              end
            end
          end
        end
        value
      end
    end
  end
end
