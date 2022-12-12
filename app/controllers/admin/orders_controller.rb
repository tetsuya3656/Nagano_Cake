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
    @order_detail = @order.order_details.all


    if @order.status == "check"
      @order_detail.update_all(making_status: 1)
    end

    redirect_to admin_order_path(@order.id)
  end



private

  def order_params
    params.require(:order).permit(:status, :making_status)
  end


end
