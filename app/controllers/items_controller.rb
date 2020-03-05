class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @items = policy_scope(Item).search_by_name_and_description(params[:query])
    else
      @items = policy_scope(Item)
    end
    @items = @items.order(created_at: :desc)
    @markers = @items.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { item: item })
      }
    end
  end

  def show
    @order = Order.new
    @user = @item.user
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def set_item
    @item = item.find(params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(:name, :description, :sport, :transaction_type, :start_date, :end_date, :size, :price, :user_id, :photo)
  end
end
