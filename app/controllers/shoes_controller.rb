class ShoesController < ApplicationController
  include ActionView::Helpers::DateHelper

  def index
    if !current_user.nil?
      @user = current_user
      @user_shoes = UserShoe.where(user: @user)
      @weekly_check_ins = CheckIn.where(created_at: Date.today.at_beginning_of_week..Time.now)
      @last_check_in = CheckIn.where(user_shoe: @user_shoes).last.created_at
      @time_since_last_check_in = time_ago_in_words(@last_check_in, include_seconds: true).concat(" ago")
      @trending_user_shoe = @weekly_check_ins.group('user_shoe_id').order('count(*) desc').limit(1).pluck('user_shoe_id').first
      @shoe_of_week = UserShoe.find(@trending_user_shoe)
    else
      @user_shoes = UserShoe.all
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
