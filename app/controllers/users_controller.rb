class UsersController < ApplicationController
    before_action :authenticate_user, only: [:update,:change_password,:change_team]
	before_action :set_user, only: [:update, :change_team  ]

  def change_password
  	@user=User.find(current_user.id)
  end

  def update
  	if @user.update(pwd_params)
  	redirect_to :ratings_new, notice: "Password Changed Successfully!"
  else
  	flash.now.alert = "Error Updating Password"
    render "change_password" 
  end
 
  end	

  def create
  @user = User.new(user_params)
  if @user.save
    redirect_to root_url, :notice => "Signed up!"
  else
    render "new"
  end
end

  def change_team
    if (request.post? || request.patch?)
      if @user.update_columns(team_params)
      redirect_to :change_team, notice: "Team Changed Successfully!"
      else
        redirect_to :change_team, alert: "Error updating team!"
      end  
    else 
    @teams=Team.all
  end
  end 

  def new
  	 @user = User.new
  end

  private 
   def set_user
      @user = User.find(current_user.id)
    end
   def pwd_params
      params.require(:user).permit(:password,:password_confirmation,:role)
    end
    def user_params
      params.require(:user).permit(:username,:first_name,:last_name,:email,:password,:password_confirmation)
    end
     def team_params
      params.require(:user).permit(:team_id)
    end

end
