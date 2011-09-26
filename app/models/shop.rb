require 'net/http'

class Shop < ActiveRecord::Base

  acts_as_mappable

  DATA_FILE_COLS =
    [
      "---",
      "Site",
      "Zip Search",
      "Shop",
      "Address",
      "Phone",
      "Make",
      "Affiliations",
      "Specialties",
      "Amenities",
      "Timestamp",
    ]

  FIELDS = 
    {
      "---" => "-1",
      "Site" => "-1",
      "Zip Search" => "-1",
      "Shop" => "name",
      "Address" => "raw_address",
      "Phone" => "phone_number",
      "Make" => "make",
      "Affiliations" => "affiliations",
      "Specialties" => "specialties",
      "Amenities" => "amenities",
      "Timestamp" => "-1"
    }

  
  def full_address
    "#{address_1} #{city} #{state} #{postal_code}"
  end

  def valid_for_geocoding?
    rtn = true 
    if self.full_address.nil? || self.full_address.to_s.empty? 
       rtn = false 
    end

    return rtn 
  end

  def geocode_address
    geo = GeoKit::Geocoders::MultiGeocoder.geocode( full_address )
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

  def geocode_raw_address
        geo = GeoKit::Geocoders::MultiGeocoder.geocode(self.raw_address)
        if ( geo.success )
          self.address_1 = geo.street_address
          self.city = geo.city
          self.state = geo.state
          self.postal_code = geo.zip
          self.lat = geo.lat
          self.lng = geo.lng
        end
  end

  def self.import( file_path )
    #url = 'http://scottsstuff.s3.amazonaws.com'
    file = '/Users/tuneyfish/htwoc2/db/HTWOC-SHOPS.txt'
    #file = file_path
     

    #response = Net::HTTP.get_response(URI.parse(url + file))
    body = response.body
    lines = body.split("\r\n")

    line_cnt = 0

    lines.each { |line| 
      if line_cnt > 1
        words = line.split("\"")
        cnt = 0
        shop_atrbs = Hash.new
        words.each { |word|
          if word != ","
            #puts "#{fields[cnt]} : #{word.strip}"
            field = FIELDS[DATA_FILE_COLS[cnt]]
            if field != "-1"
              shop_atrbs[field] = word.strip
            end
            cnt = cnt + 1
          end
        }
        shop = Shop.new
        shop.update_attributes(shop_atrbs)
        geo = GeoKit::Geocoders::MultiGeocoder.geocode(shop.raw_address)
        shop.address_1 = geo.street_address
        shop.city = geo.city
        shop.state = geo.state
        shop.postal_code = geo.zip
        shop.lat = geo.lat
        shop.lng = geo.lng
        shop.save

      end
      line_cnt = line_cnt + 1
    }    #f.each{ |line| puts '#{f.lineno}: #{line}' }
  end

  def self.fetch_not_geocoded
    find( :all,
    :conditions => ['lat IS NULL || lng IS NULL || lat = ? || lng = ?', "", ""],
    :limit => 10000)
  end

  def self.find_for_sitemap(offset, limit)
    find( :all, 
          :select => 'id, name, updated_at',
          :order => 'updated_at DESC',
          :offset => offset,
          :limit => limit )
  end

end
