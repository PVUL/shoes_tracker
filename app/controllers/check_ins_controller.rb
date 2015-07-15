class CheckInsController < ApplicationController

  def create
    @user = current_user
    @userShoe = UserShoe.find_by(shoe: params[:shoe_id])
    @date = Time.now.strftime("%m/%d/%y")
    @checkIn = CheckIn.new(user_shoe: @userShoe, date: @date)
    if @checkIn.save
      flash[:notice] = "Successfully Checked In"
      redirect_to root_path
    end
  end
end
