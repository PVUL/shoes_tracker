class UserShoesController < ApplicationController
  def new
    @user_shoe = UserShoe.new
    @shoe = Shoe.new
  end

  def create
    @user = current_user
    @shoe = Shoe.new(shoe_params)
    if @shoe.save
      @user_shoe = UserShoe.new(user_shoe_params)
      @user_shoe.user = @user
      @user_shoe.shoe = @shoe
      @user_shoe.save!
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
