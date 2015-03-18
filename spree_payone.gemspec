Gem::Specification.new do |s|
  s.name                  = 'spree_payone'
  s.version               = '2.0.0.beta'
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.0.0'
  s.license               = 'BSD'
  s.summary               = 'Spree Extension for PAYONE'
  s.description           = 'Payment gateway and methods for PAYONE FinanceGate Server for Spree 2.x'

  s.authors     = ['Thomas von Deyen', 'Pascal Jungblut', 'Maciej Gowin', 'Florian Salis']
  s.email       = 'mail@magiclabs.de'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path  = 'lib'

  s.add_dependency('spree_core',  '~> 3.0')

  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'sass-rails', '~> 5.0.0.beta1'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'launchy'
end
