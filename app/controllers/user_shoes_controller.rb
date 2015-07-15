class UserShoesController < ApplicationController
  def new
    @userShoe = UserShoe.new
    @shoe = Shoe.new
  end

  def create
    @user = current_user
    @shoe = Shoe.new(shoe_params)
    if @shoe.save
      @userShoe = UserShoe.new(user_shoe_params)
      @userShoe.user = @user
      @userShoe.shoe = @shoe
      @userShoe.save
      flash[:notice] = 'Successfully Added'
      redirect_to root_path
    else
      flash[:notice] = @shoe.errors.full_messages.join('. ')
      render :new
    end
  end

  private

  def shoe_params
    params.require(:shoe).permit(:model, :brand, :color)
  end

  def user_shoe_params
    params.require(:user_shoe).permit(:image)
  end
end
