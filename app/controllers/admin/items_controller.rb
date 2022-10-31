class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  def show
  end

  def edit
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active)
  end
end
