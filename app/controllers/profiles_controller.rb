class ProfilesController < ApplicationController
  def new
    @profile = User.new
    authorize @profile
  end

  def create
    @profile = current_user
    if @profile.update(user_params)
      redirect_to items_path
    else
      render :new
    end
     authorize @profile
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :address)
  end
end
