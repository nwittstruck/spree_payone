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

  s.add_development_dependency 'rspec-rails'
end
