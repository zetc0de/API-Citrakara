class Transaction < ApplicationRecord
	belongs_to :user
	mount_uploader :bukti, ImagepathUploader
end
