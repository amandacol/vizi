class UsersController < ApplicationController
  before_action :set_user, only: [:show, :index]

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def index
    if params[:query].present?
      @users = policy_scope(User).search_by_name(params[:query])
    else
      @users = policy_scope(User)
    end
    #@soaps = @soaps.order(created_at: :desc)
    #@markers = @soaps.map do |soap|
      #{
        #lat: soap.latitude,
        #lng: soap.longitude,
        #infoWindow: render_to_string(partial: "info_window", locals: { soap: soap })
      #}
    #end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
