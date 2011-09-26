ActiveAdmin.register Shop do
  
  index do
    column :name do |shop|
	  link_to shop.name, [shop]
	end
	column "Brands", :make
	column "Telephone", :phone_number
	column "Street", :address_1
	column :city
	column :state
	column "Zip", :postal_code
	default_actions
  end
end
