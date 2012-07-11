class TagsController < ApplicationController
  def index
  	@tags = Tag.paginate(:page => params[:page],:per_page => 2)
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end
end
