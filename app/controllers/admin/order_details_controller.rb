class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)


    if @order_detail.making_status == "making"
      @order.update(status: 2)
    end

    change_status(@order)





    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def change_status(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != "completed"
        return
      end

    end

      order.update(status: 3)
  end
end
