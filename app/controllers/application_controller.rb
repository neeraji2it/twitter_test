class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!
	before_action :profile_exist?

	def profile_exist?
		if user_signed_in?
			unless current_user.profile
				redirect_to new_profile_path
			end
		end
	end

	def not_found
		flash[:alert] = "No Route found."
		redirect_to home_index_path
	end

	protected
		rescue_from ActiveRecord::RecordNotFound do |exception|
			flash[:alert] = exception.message
			redirect_to home_index_path
		end
		rescue_from *[SocketError, Errno::ECONNREFUSED, Net::ReadTimeout] do |exception|
			flash[:alert] = exception.message
			redirect_to home_index_path
		end
		rescue_from CanCan::AccessDenied do |exception|
			flash[:alert] = exception.message
			redirect_to home_index_path
		end
end
