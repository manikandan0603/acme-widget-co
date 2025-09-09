# spec/basket_spec.rb
require_relative '../lib/basket'

RSpec.describe 'Basket' do
  let(:catalogue) do
    {
      'R01' => { name: 'Red Widget',   price_cents: 3295 },
      'G01' => { name: 'Green Widget', price_cents: 2495 },
      'B01' => { name: 'Blue Widget',  price_cents: 795  },
    }
  end

  let(:delivery_rules) do
    [
      { min_subtotal_cents: 0,    fee_cents: 495 },
      { min_subtotal_cents: 5000, fee_cents: 295 },
      { min_subtotal_cents: 9000, fee_cents: 0 },
    ]
  end

  let(:delivery) { DeliveryThreshold.new(delivery_rules) }
  let(:offers) { [BuyOneGetSecondOneHalf.new('R01')] }

  it 'calculates example baskets correctly' do
    b1 = Basket.new(catalogue: catalogue, delivery_rules: delivery, offers: offers)
    b1.add('B01').add('G01')
    expect(b1.total.to_s).to eq('$37.85')

    b2 = Basket.new(catalogue: catalogue, delivery_rules: delivery, offers: offers)
    b2.add('R01').add('R01')
    expect(b2.total.to_s).to eq('$54.38')

    b3 = Basket.new(catalogue: catalogue, delivery_rules: delivery, offers: offers)
    b3.add('R01').add('G01')
    expect(b3.total.to_s).to eq('$60.85')

    b4 = Basket.new(catalogue: catalogue, delivery_rules: delivery, offers: offers)
    %w[B01 B01 R01 R01 R01].each { |c| b4.add(c) }
    expect(b4.total.to_s).to eq('$98.28')
  end
end
