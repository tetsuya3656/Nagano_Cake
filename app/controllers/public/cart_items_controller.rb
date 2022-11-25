class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    render index
  end

  def subtotal
   item.with_tax_price * amount
  end

  private
    def cart_item_params
     params.require(:cart_item).permit(:amount, :item_id)
    end

end
