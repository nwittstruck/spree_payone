# Spree PAYONE (Paymentgateway)

Add support for PAYONE payment methods and gateway as a payment methods.

## Installation

#### 1. Add the following to your Gemfile

```ruby
gem 'spree_payone', github: 'magiclabs/spree_payone'
```

#### 2. Run

```bash
$ bundle install
```

#### 3. To copy and apply migrations, inject JavaScript and CSS includes run:

```bash
$ bin/rails g spree_payone:install
```

## Configuring

After the installation visit 'PAYONE Documentation' under the 'Configuration' tab.

## Dependencies

* [Spree](https://github.com/spree/spree) (spree_core 2.x)

## License

* BSD
