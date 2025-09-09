# frozen_string_literal: true

require_relative '../lib/basket'

catalogue = {
  'R01' => { name: 'Red Widget',   price_cents: 3295 },
  'G01' => { name: 'Green Widget', price_cents: 2495 },
  'B01' => { name: 'Blue Widget',  price_cents: 795  },
}

delivery_rules = [
  { min_subtotal_cents: 0,    fee_cents: 495 },
  { min_subtotal_cents: 5000, fee_cents: 295 },
  { min_subtotal_cents: 9000, fee_cents: 0 },
]

delivery = DeliveryThreshold.new(delivery_rules)
offers = [BuyOneGetSecondOneHalf.new('R01')]

def run_and_print(codes, catalogue, delivery, offers)
  b = Basket.new(catalogue: catalogue, delivery_rules: delivery, offers: offers)
  codes.each { |c| b.add(c) }
  puts "#{codes.join(', ')} => Subtotal: #{b.subtotal} Delivery: #{b.delivery_fee_cents / 100.0}  Total: #{b.total}"
end

run_and_print(%w[B01 G01], catalogue, delivery, offers)
run_and_print(%w[R01 R01], catalogue, delivery, offers)
run_and_print(%w[R01 G01], catalogue, delivery, offers)
run_and_print(%w[B01 B01 R01 R01 R01], catalogue, delivery, offers)
