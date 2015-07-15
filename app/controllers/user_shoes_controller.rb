class UserShoesController < ApplicationController
  def new
    @user_shoe = UserShoe.new
    @shoe = Shoe.new
  end

  def create
    @user = current_user
    @shoe = Shoe.new(shoe_params)
    @image = params[:user_shoe][:image] if !params[:user_shoe].nil?
    if @shoe.save
      @user_shoe = UserShoe.new(user: @user, shoe: @shoe, image: @image)
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
end
