class PostsController < ApplicationController
  #http_basic_authenticate_with :name => "root", :password => "root", :except => [:index, :show]
  before_filter :authenticate_user!, :except => [:show, :index]
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @posts = Post.paginate(:page => params[:page],:per_page => 2)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.paginate(:page => params[:page],:per_page => 1)
    @tag = @post.tags
    #@tag = Tag.find(:all, :conditions => ["post_id = ?", params[:id]])

    @title = @post.title
    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @post }
      format.js # default : index.js.erb
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create    
    @tag = params["post"]["tags_attributes"]
    @tags = params["post"]["tags_attributes"]["0"]["name"].split(",")
    @tag.clear
    @tags.each_with_index do |tag,i|
      puts i
    end
    #@post = Post.new(params[:post])

    #@tags = params[:post][:tags_attributes]["0"][:name].split(",")
    #respond_to do |format|
    #  if @post.save
    #    format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #    format.json { render json: @post, status: :created, location: @post }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @post.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
