class ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
    @user = current_user
  end

  def new
    @shoe = Shoe.new
  end

  def create
    @shoe = Shoe.new(shoe_params)
    @collection = Collection.new
    @collection.user = current_user
    @collection.shoe = @shoe
    if @shoe.save
      if !@collection.user.nil?
        @collection.save
        redirect_to user_collections_path(@collection.user)
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
    @collection = Collection.find_by(shoe_id: params[:id])
    @user = current_user
    if !current_user.nil? && !@collection.nil?
      @collection.destroy
      redirect_to user_collections_path(@user)
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
