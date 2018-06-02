class Painting < ApplicationRecord
 belongs_to :user
 has_many :comments
 mount_uploader :imagepath, ImagepathUploader
end
