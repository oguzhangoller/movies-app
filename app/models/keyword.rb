# frozen_string_literal: true

class Keyword < ApplicationRecord
  has_many :movie_keywords, foreign_key: :keyword_id, dependent: :destroy, inverse_of: false
  has_many :movies, through: :movie_keywords

  validates :name, presence: true
end
