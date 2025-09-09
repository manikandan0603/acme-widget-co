class BuyOneGetSecondOneHalf
  def initialize(code)
    @code = code
  end

  def apply(items, catalogue)
    count = items.count { |c| c == @code }
    return 0 if count < 2

    price = catalogue[@code][:price_cents]
    pairs = count / 2
    (pairs * (price / 2.0)).to_i
  end
end
