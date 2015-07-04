class ShoesController < ApplicationController
  def index
    if !current_user.nil?
      @user = current_user
      @shoes = @user.shoes
    else
      @shoes = Shoe.all
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
    @shoe = Shoe.new(shoe_params)
    if @shoe.save && !current_user.nil?
      @userShoe = UserShoe.new(user: current_user, shoe: @shoe)
      @userShoe.save
      flash[:notice] = 'Successfully Added'
      redirect_to shoes_path
    else
      flash[:notice] = @shoe.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def destroy
    @userShoe = User_shoe.find_by(shoe_id: params[:id])
    @user = current_user
    if !current_user.nil? && !@userShoe.nil?
      @userShoe.destroy
      redirect_to user_shoes_path
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
