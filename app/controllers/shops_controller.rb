class ShopsController < ApplicationController
  # GET /shops
  # GET /shops.xml
  def index
    @zip = params[:zip]
    @distance = params[:distance]
    
    if @zip && @distance 
      @shops = Shop.find(:all, :origin => @zip, :conditions => ["distance < ?", @distance])
      logger.debug( "found #{@shops.length} shops" )

      if @shops.length == 0
        geo = GeoKit::Geocoders::MultiGeocoder.geocode( @zip )
        errors.add(:address, "Could not Geocode address") if !geo.success
        @centerLat, @centerLng = geo.lat,geo.lng if geo.success
      else
        @centerLat = @shops[0].lat
        @centerLng = @shops[0].lng
      end
    else
      @shops = []

      geo = GeoKit::Geocoders::IpGeocoder.geocode(request.remote_ip)
      if geo.success
        @centerLat, @centerLng = geo.lat,geo.lng 
      else
        logger.debug( "unable to geocode remote ip" )
        @centerLat = 42 
        @centerLng = -120 
      end
    end

    if @distance.nil?
      @distance = 5
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end
  
   def geocode_shops
    @shops_to_geocode = Shop.fetch_not_geocoded
    cnt = 0
    for shop in @shops_to_geocode
      shop.geocode_raw_address
      shop.save!
    end
    redirect_to :action => 'admin_index'
  end

  # GET /shops/1
  # GET /shops/1.xml
  def show
    @shop = Shop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/new
  # GET /shops/new.xml
  def new
    @shop = Shop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops
  # POST /shops.xml
  def create
    @shop = Shop.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: "new" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shops/1
  # PUT /shops/1.xml
  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.xml
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :ok }
    end
  end
end
