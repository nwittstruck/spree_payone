# Responsible for parameters storage and auto-generation of parameter getters/setters.
module Spree::Payone
  module Proxy
    class ParameterContainer
      # Generates accessors for parameters.
      def self.parameter_accessor(parameter_name, parameter_setter = true, parameter_getter = true)
        if parameter_setter
          define_method "#{parameter_name}=" do |val|
            self.add_parameter(parameter_name.to_sym, val)
          end
        end
        if parameter_getter
          define_method "#{parameter_name}" do
            self.get_parameter(parameter_name.to_sym)
          end
        end
      end

      # Generates values accessors for parameters.
      def self.parameter_value_accessor(parameter_method, parameter_name, parameter_value)
        define_singleton_method "#{parameter_method}_value" do
          parameter_value
        end
        define_method parameter_method do
            eval("self.#{parameter_name}= '#{parameter_value}'")
        end
        define_method "#{parameter_method}?" do
            eval("self.#{parameter_name} == '#{parameter_value}'")
        end
      end

      # Sets initial data.
      def initialize
        @parameters = {}
      end

      # Adds parameter to hash.
      def add_parameter(key, value)
        @parameters[key] = value
      end

      # Removes parameter from hash.
      def remove_parameter(key)
        if @parameters.key? key
          @parameters.delete key
        else
          false
        end
      end

      # Returns parameter value.
      def get_parameter(key)
        if @parameters.key? key
          @parameters[key]
        else
          nil
        end
      end

      # Returns parameters hash.
      def parameters
        @parameters
      end

      # Deletes all parameters form hash.
      def delete_parameters
        @parameters.clear
      end

      # Sets parameters hash.
      def parameters= value
        if value.is_a? Hash
          @parameters = value
        end
      end

      def to_s
        result = ''
        @parameters.each do |key, value|
          result += "#{key}: \"#{value}\"\n"
        end
        result.strip
      end
    end
  end
end
