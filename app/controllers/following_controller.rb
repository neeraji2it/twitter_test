class FollowingController < ApplicationController
	before_action :load_following

	def follow
		@following.update(is_following: true)
		render json: true
	end

	def unfollow
		@following.update(is_following: false)
		render json: true
	end

	def following_list
		@total_following = User.joins("INNER JOIN followings on users.id = followings.following_user_id").where("followings.user_id = ? AND is_following =?", current_user.id, true)
	end

	def followers
		@total_followers = User.joins("INNER JOIN followings on users.id = followings.user_id").where("followings.following_user_id = ? AND is_following =?", params[:user_id], true)
	end

	private

	def load_following
		@following = Following.find_or_create_by(following_user_id: params[:following_user_id], user_id: current_user.id)
	end
end
