class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
    authorize @order
    if @order.item.transaction_type == "Rental"
      @order.amount = @order.amount.to_i * (Date.parse(@order.rent_end_date) - Date.parse(@order.rent_start_date)).to_i
    end
  end
end
