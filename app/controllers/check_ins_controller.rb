class CheckInsController < ApplicationController
  def create
    @user_shoe_id = params[:shoe_id]
    @user_shoe = UserShoe.find(@user_shoe_id)
    @date = Date.today
    @check_in = CheckIn.new(user_shoe: @user_shoe, date: @date)
    if @check_in.save
      flash[:notice] = "Successfully Checked In"
      redirect_to root_path
    end
  end
end
