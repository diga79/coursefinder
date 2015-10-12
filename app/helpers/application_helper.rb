module ApplicationHelper
	def nav_items
		[
			{
				displaytext: 'Institutions',
				controllername: 'institutions',
				linkurl: institutions_path
			},
			{
				displaytext: 'Courses',
				controllername: 'courses',
				linkurl: course_options_path
			},
			{
				displaytext: 'Students',
				controllername: 'students',
				linkurl: students_path
			},
			{
				displaytext: 'Applications',
				controllername: 'applications',
				linkurl: applications_path
			}
		]
	end

	def display_nav_items (displaytext, controllername, linkurl)
		raw("<li#{controller_name == controllername ? ' class="active"' : ''}>#{link_to displaytext, linkurl}</li>")
	end
	
	def user_logged_in_msg
		str = ''
		str += '<div class="userloggedin">'
		if user_signed_in?
			str += "<p id=""user_info"">Hi #{current_user}! #{link_to('Logout', destroy_user_session_path, :method => :delete)}</p>"
		else
			str += "<p id=""user_info"">#{link_to('Login', new_user_session_path)} | #{link_to('Register', new_user_registration_path)}</p>"
		end
		str += '</div>'
		raw(str)
	end	
	
	def sidebar
		unless ['sessions', 'registrations'].include?(controller_name)
			index_title = "All #{controller_name.capitalize}"
			index_path = "#{controller_name}_path"
			new_title = "New #{controller_name.singularize.capitalize}"
			new_path = "new_#{controller_name.singularize}_path"
			str_rtn = "<ul class=""list2 col2""><li>#{link_to index_title, eval(index_path)}</li>"
			if user_signed_in?
				str_rtn = str_rtn + "<li>#{link_to new_title, eval(new_path)}</li>"
			end
			str_rtn = str_rtn + "</ul>"
			raw(str_rtn)
		end
	end
end