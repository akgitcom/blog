class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    #@products = Product.all
    @products = Product.paginate( :page => params[:page],
                            :per_page => 15
                          )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def it
    # Get a Nokogiri::HTML::Document for the page we’re interested in...
    require 'nokogiri'
    require 'open-uri'
    page = params['page']
    @sarr = []
    # for page in (1..100).to_a do
    # Search_1_page1.html
    url = 'http://www.sosoina.com/Search_1_page'+page.to_s+'.html'
    @doc = Nokogiri::HTML(open(url), nil, "utf-8")
    @li = {}
    @doc.css('.sr li').each_with_index do |link,i|
      if i>5
        @li[i] = {:txt => link.content}
      end
    end
    @liarr = []
    @doc.css('.sr li').each do |link|
        @liarr << link.content
    end
    @liarr.each_with_index do |la,i|
      if i<6
        @liarr.shift
      end
    end
    @sarr << @liarr.in_groups_of(6)
    @postreset = []
    # Create an Array of new objects
	# Product.create([{ :ProductRela => '000399|000401' }, { :ProductRela => '000399|000402' }])
    @sarr[0].each_with_index do |value,i|
    	@postreset << {
    		:ProductRela => '000399|000401',
    		:ProductName => @sarr[0][i][0],
    		:ProductSpeci => @sarr[0][i][1],
    		:ProductPrice => @sarr[0][i][2],
    		:ProductCoding => @sarr[0][i][3],
    		:ProductBrand => @sarr[0][i][4],
    		:ProductModel => @sarr[0][i][5],
    		:ProductSecrecy => 0,
    		:ProductNew => 1, 
    		:ProductRecommended => 1, 
    		:ProductAudit => 1, 
    		:ProductClick => 1, 
    		:ProductAgree => 0, 
    		:ProductDisagree => 0, 
    		:ProductSort => 0, 
    		:ProductPublished => 'gzyz', 
    		:ProductTime => Time.now
    	}	
    end
    Product.create(@postreset)
    # @product = Product.new(@postreset)

    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to @product, notice: 'Product was successfully created.' }
    #     format.json { render json: @product, status: :created, location: @product }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end
end
