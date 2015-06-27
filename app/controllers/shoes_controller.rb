class ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
  end

  def new
    @shoe = Shoe.new
  end

  def create
    @shoe = Shoe.new(shoe_params)
    if @shoe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def destroy
    @shoe = Shoe.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  private

  def shoe_params
    params.require(:shoe).permit(:model, :brand, :color)
  end

end
