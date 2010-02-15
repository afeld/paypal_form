class CreatePriceOptions < ActiveRecord::Migration
  def self.up
    create_table :price_options do |t|
      t.string :title
      t.decimal :value, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :price_options
  end
end
