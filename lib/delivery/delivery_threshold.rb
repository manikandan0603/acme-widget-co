class DeliveryThreshold
  def initialize(rules)
    @rules = rules.sort_by { |r| r[:min_subtotal_cents] }
  end

  def fee_for(subtotal_cents)
    rule = @rules.reverse.find { |r| subtotal_cents >= r[:min_subtotal_cents] } || @rules.first
    Money.new(rule[:fee_cents])
  end
end
