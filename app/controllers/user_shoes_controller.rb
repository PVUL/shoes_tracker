class UserShoesController < ApplicationController
  def new
    @shoe = Shoe.new
  end

  def create
    @userShoe = UserShoe.new(user_shoe_params)
    # if @userShoe.save

  end

  def index
    @user = User.find_by(params[:id])
    @shoes = @user.shoes
  end

  def edit
  end

  private

  def user_shoe_params
    params.require(:user_shoe).permit(:model, :brand, :color)
  end

end
