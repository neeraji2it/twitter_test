class Tweet < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :message, :user_id, presence: true
	validates_length_of :message, maximum: 280, allow_blank: true
	belongs_to :user
	has_many :likes
	has_many :comments
end
