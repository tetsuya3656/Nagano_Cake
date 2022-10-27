class OrderDetail < ApplicationRecord
  enum making_status: { not_making: 0, wait: 1, making: 2, completed: 3 }
end
