class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all


  end

  def show
  end

  def index
  end

  def comfirm
    @order = Order.new(order_params)

    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_number] == "2"

    end
  end

  def complete
  end

  private

 def order_params
   params.require(:order).permit(:postal_code, :name, :address, :total_payment, :shipping_cost, :payment_method, :status, :customer_id)
 end

end
