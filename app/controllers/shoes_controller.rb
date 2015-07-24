class ShoesController < ApplicationController
  include ActionView::Helpers::DateHelper

  def index
    if !current_user.nil?
      @user = current_user
      @user_shoes = UserShoe.where(user: @user)
      @check_ins = CheckIn.where(user_shoe: @user_shoes)

      @today = Date.today

      @this_week = @today.last_week(:sunday)..@today.end_of_week(:sunday)
      @last_week = @today.last_week(:sunday).weeks_ago(
        1)..@today.end_of_week(:sunday).weeks_ago(1)

      @this_week_view = @this_week.map { |date| date.strftime("%d") }
      @last_week_view = @last_week.map { |date| date.strftime("%d") }

      if !@check_ins.empty?
        @last_check_in = @check_ins.last.created_at
        @time_since_last_check_in = time_ago_in_words(
          @last_check_in, include_seconds: true).concat(" ago")
        @this_week_check_ins = @check_ins.where(
          created_at: @today.at_beginning_of_week(:sunday)..Time.now)
        @last_week_check_ins = @check_ins.where(
          date: @today.last_week(:sunday).weeks_ago(1).strftime(
            "%d")..@today.end_of_week(:sunday).weeks_ago(1).strftime("%d"))
        @trending_user_shoe = @this_week_check_ins.group(
          'user_shoe_id').order('count(*) desc').limit(1).pluck(
            'user_shoe_id').first
        @shoe_of_week = UserShoe.find(@trending_user_shoe)
      end
    else
      @user_shoes = UserShoe.all
    end
  end

  def show
    @user = current_user
    @user_shoes = UserShoe.where(user: @user)
    @user_shoe = UserShoe.find(params[:id])

    respond_to do |format|
      format.js
    end

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
