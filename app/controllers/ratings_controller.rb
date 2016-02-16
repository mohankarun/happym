class RatingsController < ApplicationController
before_action :set_rating ,only: [:update]
 before_action :authenticate_user
 @chart_data;
  def new
  	@selected_date = Time.now.to_date
   @rating  = Rating.find_or_initialize_by(:recorded => @selected_date, :user => current_user)
   @rating.update(user: current_user)
   if @rating.happy_level.nil?
   @rating.update(happy_level: 50.0)
  end
   @rating.save
  end
  def show
  end	

  def update
  	  if @rating.update(rating_params)
       flash.now.notice = "Rating Successfully Updated"
       render "new"
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
  end	
private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
     def rating_params
      params.require(:rating).permit(:happy_level, :recorded, :user)
    end
end
