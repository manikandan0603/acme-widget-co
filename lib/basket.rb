# frozen_string_literal: true

# lib/basket.rb
require_relative 'offers/buy_one_get_second_one_half'
require_relative 'delivery/delivery_threshold'
class Basket
  attr_reader :catalogue, :delivery_rules, :offers, :items

  def initialize(catalogue:, delivery_rules:, offers: [])
    @catalogue = catalogue
    @delivery_rules = delivery_rules
    @offers = offers
    @items = []
  end

  def add(code)
    raise ArgumentError, "Unknown product code #{code}" unless catalogue.key?(code)

    items << code
    self
  end

  def subtotal_cents
    items_sum = items.map { |c| catalogue[c][:price_cents] }.sum
    discount = offers.map { |o| o.apply(items.dup, catalogue) }.sum
    items_sum - discount
  end

  def delivery_fee_cents
    st = subtotal_cents
    delivery_rules.fee_for(st)
  end

  def total_cents
    subtotal_cents + delivery_fee_cents
  end

  def total
    format_cents(total_cents)
  end

  def subtotal
    format_cents(subtotal_cents)
  end

  private

  def format_cents(cents)
    dollars = cents / 100
    remainder = cents.abs % 100
    format("$%d.%02d", dollars, remainder)
  end
end

