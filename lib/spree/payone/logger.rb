# Provides simple logging functionallity based on standard logger and add additional
# operations on PAYONE logs.
module Spree::Payone
  class Logger
    include Singleton

    # Native logger object
    attr_reader :native_logger

    # Sets initial data.
    def initialize
      @native_logger = ::Logger.new Spree::Config[:payone_logger_filepath]
    end

    # DB logger enabled/disabled.
    def db_enabled?
      Spree::Config[:payone_db_logging_enabled]
    end

    # File logger enabled/disabled.
    def file_enabled?
      Spree::Config[:payone_file_logging_enabled]
    end

    # Logs if logging enabled.
    def log level, message
      timestamp = Time.now.utc.to_s
      if db_enabled?
        Spree::PayoneLog.create(level: level.to_s.upcase, message: message.to_s.force_encoding('iso-8859-1').encode('UTF-8'))
      end

      # File logger
      if file_enabled?
        native_logger.debug '[' + timestamp + '] ' + level.to_s.upcase + ' -- : ' + message
      end
    end

    # Logs debug message.
    def debug message
      self.log :debug, message
    end

    # Logs error message.
    def error message
      self.log :error, message
    end

    # Logs fatal message.
    def fatal message
      self.log :fatal, message
    end

    # Logs info message.
    def info message
      self.log :info, message
    end

    # Logs warn message.
    def warn message
      self.log :warn, message
    end

    # Logs debug message.
    def self.debug message
      Spree::Payone::Logger.instance.debug message
    end

    # Logs error message.
    def self.error message
      Spree::Payone::Logger.instance.error message
    end

    # Logs fatal message.
    def self.fatal message
      Spree::Payone::Logger.instance.fatal message
    end

    # Logs info message.
    def self.info message
      Spree::Payone::Logger.instance.info message
    end

    # Logs warn message.
    def self.warn message
      Spree::Payone::Logger.instance.warn message
    end
  end
end
