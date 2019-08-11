class HomeController < ApplicationController

	def index
		@tweets = Tweet.includes(:user => :profile).order("created_at DESC").limit(10)
	end

	def search_user		
		@users = User.joins(:profile).where("( users.email LIKE ? OR profiles.first_name LIKE ? ) AND users.id != ?", "%#{params[:search]}%", "%#{params[:search]}%", current_user.id)
		respond_to do |format|
			format.js
		end
	end

	def tweets
		@tweets = Tweet.all
	end
end
