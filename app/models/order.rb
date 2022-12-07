class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, check: 1, making: 2, in_preparation: 3, shipped: 4 }

  belongs_to :customer
  has_many :order_details
  def subtotal
   item.with_tax_price * amount
  end
end
