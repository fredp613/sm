

class HomeController < ApplicationController
 
  def index
     			 
	if !params[:search_field].blank? || !params[:search_field].nil? || !params[:search_field] == ""
	
				
		query = Content.search(params[:search_field])
		@contents = Kaminari.paginate_array(query).page(params[:page]).per(21)
		
		if @contents.length == 0
			flash.now[:alert] = "Sorry, no results found"			
		else
			unless params[:page]
				flash.now[:notice] = "Your search yieled #{query.count} results!"
			end
		end		
	else
		@contents = Content.all.page(params[:page]).per(21)
	end

	if params[:clear] 
		flash.now[:notice] = "Cleared"
		
		@contents = Content.all.page(params[:page]).per(21)	
		redirect_to "/"

		
	end
	 
  end

end
