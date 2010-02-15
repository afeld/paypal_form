class AddProgram < ActiveRecord::Migration
  def self.up
	add_column :schools, :program, :string, :default => "peewee"
  end

  def self.down
	remove_column :schools, :program
  end
end
