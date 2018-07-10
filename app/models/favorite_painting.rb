class FavoritePainting < ApplicationRecord
    belongs_to :painting
    belongs_to :user

	validates :painting_id, uniqueness: { scope: :user_id }
end
