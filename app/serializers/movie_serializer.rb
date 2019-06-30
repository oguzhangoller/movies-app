# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :year, :rating, :poster_path, :language
  has_many :categories
  has_many :actors
end
