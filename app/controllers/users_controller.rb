class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => []
  	load_and_authorize_resource
	def index
		#@posts = Post.all
	    @users = User.paginate(:page => params[:page],:per_page => 2)
	    @title = 'manager users'
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @users }
	    end
	end
end
