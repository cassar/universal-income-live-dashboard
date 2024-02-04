class Distribution < ApplicationRecord
  has_many :dividends, dependent: :destroy

  def dividend_amount_formatted
    Money.from_cents(dividend_amount_in_base_units).format
  end
end
