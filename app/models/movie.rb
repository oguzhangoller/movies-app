# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :movie_categories, foreign_key: :movie_id, dependent: :destroy
  has_many :categories, through: :movie_categories

  validates :name, presence: true
end
