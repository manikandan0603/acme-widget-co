Acme Widget Co
Principles applied:

Small, focused classes (Money, Basket, ThresholdDelivery, Offer)
Strategy pattern for delivery and offers (inject behaviors)
Dependency injection via initializer for easier testing and extension
RSpec tests to verify expected totals

Run examples
$ ruby examples/run_examples.rb

Run tests (requires rspec)
 rspec spec/basket_spec.rb
