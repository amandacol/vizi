class OrdersController < ApplicationController
   before_action :set_order, only: [:destroy]
  def new
    @order = Order.new
    authorize @order
  end
def index
  if params[:query].present?
      @orders = policy_scope(Order).search_by_name_and_description(params[:query])
    else
      @orders = policy_scope(Order)
    end
    @orders = @orders.order(created_at: :desc)
    # @markers = @orders.map do |order|
    #   {
    #     lat: order.latitude,
    #     lng: order.longitude,
    #     # infoWindow: render_to_string(partial: "info_window", locals: { order: order })
    #   }
    end

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new
    authorize @order
    @order.item = @item
    @order.user = current_user
    @order.date = Time.now
    @order.save
    redirect_to items_path, notice: "Successfully added to cart!"
  end

  def destroy
    @order.destroy
    authorize @order
    redirect_to items_path
  end

  def deliver
    orders = current_user.orders.where(delivered: false)
    authorize orders
    orders.each do |order|
      order.delivered = true #metodo usado para "pular" a validacao do belongs_to
      order.save(validate: false)
    end
    redirect_to items_path, notice: "Thank's for your purchase..!"
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:date)
  end
end
