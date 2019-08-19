# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :movie_categories, foreign_key: :movie_id, dependent: :destroy, inverse_of: false
  has_many :movie_keywords, foreign_key: :movie_id, dependent: :destroy, inverse_of: false
  has_many :movie_actors, foreign_key: :movie_id, dependent: :destroy, inverse_of: false

  has_many :categories, through: :movie_categories
  has_many :keywords, through: :movie_keywords
  has_many :actors, through: :movie_actors

  validates :name, presence: true
end
