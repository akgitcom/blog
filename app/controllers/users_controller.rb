class UsersController < ApplicationController
	def index
		#@posts = Post.all
	    @users = User.paginate(:page => params[:page],:per_page => 2)
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @users }
	    end
	end
end
