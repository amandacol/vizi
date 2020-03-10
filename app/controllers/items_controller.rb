class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.user = current_user
    @item.address = current_user.address
    @item.latitude = current_user.latitude
    @item.longitude = current_user.longitude

    if @item.save!
      redirect_to items_path(@item)
    else
      render :new
    end

  end

  def index
    @sports = Sport.all
    if params[:query].present?
      @items = policy_scope(Item).search_by_name_and_description(params[:query])
    else
      @items = policy_scope(Item)
    end

    if params[:sport]
      @items = @items.joins(:sport).where(sports: {id: params[:sport]})
    end

    if params[:location].present?
      @items = @items.near(params[:location], params[:distance] || 10, order: :distance)
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
    @wishlist = Wishlist.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
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
    @item = Item.find(params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(:name, :description, :sport_id, :transaction_type, :start_date, :end_date, :size, :price, :user_id, :photo)
  end
end
