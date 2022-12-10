class Public::HomesController < ApplicationController
  def top
    @order_details = OrderDetail.all
    @items = Item.all
  end

  def about
  end
end
