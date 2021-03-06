class ShoesController < ApplicationController
  include ActionView::Helpers::DateHelper

  def index
    if !current_user.nil?
      @user = current_user
      @user_shoes = UserShoe.where(user: @user)
      @check_ins = CheckIn.where(user_shoe: @user_shoes)

      @sunday = Date.today.beginning_of_week(:sunday)
      @saturday = Date.today.end_of_week(:sunday)

      @last_week = (@sunday - 7..@saturday - 7).to_a
      @this_week = (@sunday..@saturday).to_a

      if !@check_ins.empty?
        @last_week_check_ins = @check_ins.where(
          date: @last_week).select("distinct on (date)*")
        @this_week_check_ins = @check_ins.where(
          date: @this_week).select("distinct on (date)*")

        @last_check_in = @check_ins.last.created_at
        @time_since_last_check_in = time_ago_in_words(
          @last_check_in, include_seconds: true).concat(" ago")

        @trending_user_shoe = @this_week_check_ins.group(
          'user_shoe_id').order('count(*) desc').limit(1).pluck(
            'user_shoe_id').first

        if !@trending_user_shoe.nil?
          @shoe_of_week = UserShoe.find(@trending_user_shoe)
        else
          @shoe_of_week = nil
        end
      end

    else
      @user_shoes = UserShoe.all
    end
  end

  def show
    @user = current_user
    @user_shoes = UserShoe.where(user: @user)
    @user_shoe = UserShoe.find(params[:id])
    @check_ins = CheckIn.where(user_shoe: @user_shoe)

    if !@check_ins.empty?
      @last_check_in = Date.parse(
        CheckIn.where(user_shoe: @user_shoe).last.date)
      @total_check_ins = CheckIn.where(user_shoe: @user_shoe).count
    else
      @last_check_in = nil
    end

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
