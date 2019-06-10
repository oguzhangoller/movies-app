class Keyword < ApplicationRecord
  has_many :movie_keywords, foreign_key: :keyword_id, dependent: :destroy
  has_many :movies, through: :movie_keywords

  validates :name, presence: true
end
