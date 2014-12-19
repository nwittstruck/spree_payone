module SpreePayone
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        append_file "#{assets_folder}/javascripts/spree/backend/all.js",
          "//= require spree_payone/admin\n"
      end

      def add_stylesheets
        inject_into_file "#{assets_folder}/stylesheets/spree/backend/all.css",
          " *= require spree_payone/admin\n",
          before: /\*\//, verbose: true
      end

      def add_migrations
        rake_task 'spree_payone:install:migrations'
      end

      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          rake_task 'db:migrate'
        else
          say "Skipping rake db:migrate, don't forget to run it!", :yellow
        end
      end

      private

      def assets_folder
        Rails.root.join("vendor/assets/")
      end

      def rake_task(name)
        run "bundle exec rake #{name}"
      end
    end
  end
end
