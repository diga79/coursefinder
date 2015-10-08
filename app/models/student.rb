class Student < ActiveRecord::Base
	has_many :applications

	validates :first_name, length: { minimum: 5 }
	validates :last_name, length: { minimum: 5 }

	def to_s
		"#{first_name} #{last_name}"
	end
end
