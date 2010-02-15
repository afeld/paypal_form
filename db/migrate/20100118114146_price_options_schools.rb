class PriceOptionsSchools < ActiveRecord::Migration
  def self.up
  	create_table :price_options_schools, :id => false do |t|
  	  t.integer :price_option_id
  	  t.integer :school_id
  	  
  	  t.timestamps
  	end
  end

  def self.down
    drop_table :price_options_schools
  end
end
