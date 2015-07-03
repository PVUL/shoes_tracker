class CollectionsController < ApplicationController
  def index
    @user = User.find_by(params[:id])
    @shoes = @user.shoes
  end

  def edit
  end
end
