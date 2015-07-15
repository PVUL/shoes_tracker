class CheckInsController < ApplicationController

  def create
    @user = current_user
    @user_shoe = @user.user_shoes.find_by(id: params[:shoe_id])
    # @user_shoe = UserShoe.find_by(shoe: params[:shoe_id])
    @date = Time.now.strftime("%m/%d/%y")
    @check_in = CheckIn.new(user_shoe: @user_shoe, date: @date)

    if @check_in.save
      flash[:notice] = "Successfully Checked In"
      redirect_to root_path
    end
  end
end
