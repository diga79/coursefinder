class Institution < ActiveRecord::Base
    has_many :courses, :through => :course_options
    has_many :course_options

	validates :name, length: { minimum: 2 }

	def to_s
		"#{name}"
	end
end
