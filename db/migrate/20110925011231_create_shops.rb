class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :make
      t.string :affiliations
      t.string :specialties
      t.string :amenities
      t.string :phone_number
      t.string :fax_number
      t.string :email
      t.string :website
      t.string :raw_address
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :postal_code
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
