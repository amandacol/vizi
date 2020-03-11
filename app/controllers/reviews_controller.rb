class ReviewsController < ApplicationController
 before_action :set_review, only: [:show, :edit]
 before_action :set_item, only: [:index, :create]

  def new
    @review = Review.new
  end

  def index
    @reviews = policy_scope(Review)
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.item = @item
    authorize @review
    if @review.save
      redirect_to @item
    else
      render :index
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def review_params
      params.require(:review).permit(:star, :comment, :item_id)
    end
end
