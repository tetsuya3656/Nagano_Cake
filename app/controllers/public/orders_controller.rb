class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def comfirm
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method].to_i
    @order.shipping_cost = 800

    if params[:order][:address_number] == "1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    end

    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #@order = current_customer.orders.new(order_params)

    @order.save!
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new(order_id: @order.id)
      @order_detail.price = cart_item.item.price
      @order_detail.item_id = cart_item.item_id

      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    redirect_to public_orders_complete_path
    @cart_items.destroy_all

  end

  def complete
  end

  def index
    @orders = current_customer.orders.all
    @cart_items = current_customer.cart_items.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    
    @order.shipping_cost = 800
    @total = 0
  end




  private

 def order_params
   params.require(:order).permit(:postal_code, :name, :address, :total_payment, :shipping_cost, :status, :customer_id)
 end

end
