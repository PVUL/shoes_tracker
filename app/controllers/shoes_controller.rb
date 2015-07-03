class ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
    @user = current_user
  end

  def new
    @shoe = Shoe.new
  end

  # must refactor this
  def create
    @shoe = Shoe.new(shoe_params)
    @userShoe = UserShoe.new
    @userShoe.user = current_user
    @userShoe.shoe = @shoe
    if @shoe.save
      if !@userShoe.user.nil?
        @userShoe.save
        flash[:notice] = 'Successfully Added'
        redirect_to user_shoes_path
      else
        redirect_to root_path
      end
    else
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
