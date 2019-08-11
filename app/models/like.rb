class Like < ApplicationRecord
	# default_scope -> { where(is_like: true) }
	belongs_to :tweet
end
