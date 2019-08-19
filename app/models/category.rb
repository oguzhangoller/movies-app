# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :movie_categories, foreign_key: :category_id, dependent: :destroy, inverse_of: false
  has_many :movies, through: :movie_categories

  validates :name, presence: true
end
