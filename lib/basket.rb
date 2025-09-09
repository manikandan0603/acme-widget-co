# frozen_string_literal: true
class Basket
  def initialize(catalogue)
    @catalogue = catalogue
    @items = []
  end

  def total
    cents = @items.map { |c| @catalogue[c][:price_cents] }.sum
    dollars = cents / 100
    remainder = cents % 100
    format('$%d.%02d', dollars, remainder)
  end
end
