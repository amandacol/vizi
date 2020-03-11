class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:destroy]
  def new
    @wishlist = Wishlist.new
    authorize @wishlist
  end
def index
  @user_items = current_user.items
  @ser_wishlists = current_user.wishlists
  if params[:query].present?
      @wishlists = policy_scope(Wishlist).search_by_name_and_description(params[:query])
    else
      @wishlists = policy_scope(Wishlist)
    end

    @wishlists = @wishlists.wishlist(created_at: :desc)
    # @markers = @wishlists.map do |wishlist|
    #   {
    #     lat: wishlist.latitude,
    #     lng: wishlist.longitude,
    #     # infoWindow: render_to_string(partial: "info_window", locals: { wishlist: wishlist })
    #   }
    end

  def create
    @item = Item.find(params[:item_id])
    @wishlist = Wishlist.new
    authorize @wishlist
    @wishlist.item = @item
    @wishlist.user = current_user
    @wishlist.save
    redirect_to items_path, notice: "Successfully added to wishlist!"
  end

  def destroy
    @wishlist.destroy
    authorize @wishlist
    redirect_to wishlists_path
  end

  def deliver
    wishlists = current_user.wishlists.where(delivered: false)
    authorize wishlists
    wishlists.each do |wishlist|
      wishlist.delivered = true #metodo usado para "pular" a validacao do belongs_to
      wishlist.save(validate: false)
    end
    redirect_to items_path, notice: "Thank's for your purchase..!"
  end

  private

  def set_wishlist
    @wishlist = wishlist.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:date)
  end

  def filter_params
    params[:wishlists_ids] ||=[] if params.has_key?(:wishlists_ids)
    params.permit(wishlist_ids:[])
  end
end
