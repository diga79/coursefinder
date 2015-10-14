class Campu < ActiveRecord::Base
	belongs_to :institution
	belongs_to :city

	validates :institution_id, presence: true
	validates :city_id, presence: true

	def to_s
		name
	end

end
