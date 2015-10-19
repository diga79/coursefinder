class Campu < ActiveRecord::Base
	belongs_to :institution
	belongs_to :city
	belongs_to :country

	validates :institution_id, presence: true
	validates :city_id, presence: true
	validates :country_id, presence: true

	def to_s
		name
	end

end
