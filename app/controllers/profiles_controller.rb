class ProfilesController < ApplicationController
  def new
    @profile = User.new
    @sports = Sport.all
    authorize @profile
  end

  def create
    @profile = current_user
    if @profile.update(user_params)
      @profile.sports.destroy_all
      params[:user][:sport_ids].each do |sport_id|
        @profile.sports << Sport.find(sport_id) if sport_id.present?
      end
      redirect_to items_path
    else
      render :new
    end
    authorize @profile
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :address, :photo, :description)
  end
end
