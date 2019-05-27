# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories

  validates :name, presence: true
end
