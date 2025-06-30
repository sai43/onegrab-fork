# frozen_string_literal: true
module Money
  def self.to_currency(amount, symbol= "₹", precision= 1)
    ActionController::Base.helpers.number_to_currency(amount, unit: symbol, precision: precision)
  end
end
