# frozen_string_literal: true
class Money
  attr_reader :cents

  def initialize(cents)
    @cents = cents.to_i
  end

  def to_s
    dollars = cents / 100
    remainder = cents.abs % 100
    format('$%d.%02d', dollars, remainder)
  end
end
