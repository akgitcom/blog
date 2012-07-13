class PostsController < ApplicationController
  #http_basic_authenticate_with :name => "root", :password => "root", :except => [:index, :show]
  before_filter :authenticate_user!, :except => [:show, :index, :tagsearch]
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @posts = Post.paginate( :page => params[:page],
                            :per_page => 2
                          )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def wap
    render :content_type=>"text/vnd.wap.wml", :layout=>false  
  end
  
  def tagsearch
    @tagname = params[:name]
    @tags = Tag.paginate( :page => params[:page],
                          :per_page => 2,
                          :conditions => ["name like ?", "%#{params[:name]}%"]
                        )
    @posts = []
    @tags.each do |tag|
      @posts = tag.posts
    end
    @posts.each do |post|
      @postobj = post
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tags }
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
    #@tag = params[:post][:tags_attributes]    

    # shanghai-zhou(105703655)  10:31:32 写的另一种方法
    # tags = ['he', 'll', 'o']
    # @tags = tags.map do |t|
    #    if Tag.find_by_name(t).blank?
    #       Tag.create(:name=>t)
    #    end
    #    Tag.find_by_name t
    # end
    # @post.tags = @tags
    # @post.save

    @tagarr = params[:post][:tags_attributes]["0"][:name].split(" ")
    @tag = {}
    @tagarr.each_with_index do |tag,i|
    #@tagarr.each do |tag|
      @tag[i] = {:name => tag}
    end

    @postreset = params[:post]
    @postreset["tags_attributes"] = @tag
    @post = Post.new(@postreset)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
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
