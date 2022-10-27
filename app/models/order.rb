class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, check: 1, making: 2, in_preparation: 3, shipped: 4 }
end
