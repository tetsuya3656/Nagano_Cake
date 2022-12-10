class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
    @customer = Customer.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
  end


private

  def order_params
    params.require(:order).permit(:status)
  end

end
