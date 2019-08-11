class Following < ApplicationRecord
	# default_scope -> { where(is_following: true) }
	belongs_to :user	
	has_one :following_user, class_name: 'User', primary_key: 'following_user_id', foreign_key: 'id'
end