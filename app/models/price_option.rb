class PriceOption < ActiveRecord::Base
	has_and_belongs_to_many :schools
	
	def full_title
		self.title + " - $" + self.value.to_s
	end
end
