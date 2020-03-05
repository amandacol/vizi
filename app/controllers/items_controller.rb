class ItemsController < ApplicationController

  def new
    @items = Item.new
    authorize @item
  end

  def create
    @item = Item.find(params[:item_id])
    @item = Item.new
    authorize @item
    @order.item = @item
    @order.user = current_user
    @order.date = Time.now
    @order.save
    redirect_to items_path, notice: "Successfully added to cart!"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

end
