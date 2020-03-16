class OrdersController < ApplicationController
  before_action :set_order, only: [:destroy]

  def new
    @order = Order.new
    authorize @order
  end

  def index
    @user_items = current_user.items
    @neighbor_orders = policy_scope(Order)
    @user_wishlists = current_user.wishlists

  end

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new
    authorize @order
    if @item.user == current_user
      redirect_to items_path, notice: "You cannot add your own item to the cart!"

    else
      @order.item = @item
      @order.user = current_user
      @order.date = Time.now
      @order.amount = @item.price
      @order.state = 'pending'

      if @item.transaction_type == "Sale"
        @order.rent_start_date = nil
        @order.rent_end_date = nil
        @order.extent = nil
      end

      if @item.transaction_type == "Rental"
        @order.extent = order_params[:extent]
        @order.rent_start_date = Date.strptime(@order.extent.split(" ")[0], '%m-%d-%Y')
        @order.rent_end_date = Date.strptime(@order.extent.split(" ")[2], '%m-%d-%Y')

      end

      @order.save


      if @item.transaction_type == "Sale"
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: @item.name,
            images: [@item.photo.service_url],
            amount: @order.amount_cents,
            currency: 'brl',
            quantity: 1
          }],
          success_url: orders_url,
          cancel_url: items_url
        )
      end

      if @item.transaction_type == "Rental"
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: @item.name,
            images: [@item.photo.service_url],
            amount: @order.amount_cents * (Date.parse(@order.rent_end_date) - Date.parse(@order.rent_start_date)).to_i,
            currency: 'brl',
            quantity: 1
          }],
          success_url: orders_url,
          cancel_url: items_url
        )
      end

      @order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(@order)
    end
  end

  def destroy
    @order.destroy
    authorize @order
    redirect_to orders_path
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
    params.require(:order).permit(:date, :rent_start_date, :rent_end_date, :extent, :state)
  end

  def filter_params
    params[:orders_ids] ||=[] if params.has_key?(:orders_ids)
    params.permit(order_ids:[])
  end
end
