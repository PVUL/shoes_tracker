class ShoesController < ApplicationController
  def index
    if !current_user.nil?
      @user = current_user
      @user_shoes = UserShoe.where(user: @user)
    else
      @user_shoes = UserShoe.all
    end
  end

  def new
    if !current_user.nil?
      @shoe = Shoe.new
    else
      flash[:notice] = 'Must be signed in to add shoes'
      redirect_to root_path
    end
  end

  def create
    @user = current_user
    @shoe = Shoe.new(shoe_params)
    @user_shoe = UserShoe.new(user: @user, shoe: @shoe)
    if @shoe.save && !@user.nil?
      @user_shoe.save
      flash[:notice] = 'Successfully Added'
      redirect_to root_path
    else
      flash[:notice] = @shoe.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def destroy
    @user_shoe = UserShoe.find(params[:id])
    @user = current_user
    if !current_user.nil? && !@user_shoe.nil?
      @user_shoe.destroy
      flash[:notice] = "Successfully Deleted"
      redirect_to root_path
    else
      @shoe = Shoe.find(params[:id]).destroy
      redirect_to root_path
    end
  end

  private

  def shoe_params
    params.require(:shoe).permit(:model, :brand, :color)
  end
end
