class Painting < ApplicationRecord
 belongs_to :user
 belongs_to :genre
 has_many :comments
 has_many :favorite_paintings
 has_many :favorited_by, through: :favorite_paintings, source: :user
 has_many :notifications
 mount_uploader :imagepath, ImagepathUploader
 acts_as_votable



end
