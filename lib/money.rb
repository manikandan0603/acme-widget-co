# frozen_string_literal: true

class Money
  attr_reader :cents

  def initialize(cents)
    @cents = cents.to_i
  end

  def +(other)
    Money.new(cents + other.cents)
  end

  def to_s
    dollars = cents / 100
    remainder = cents % 100
    format('$%d.%02d', dollars, remainder)
  end
end
