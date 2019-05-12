# frozen_string_literal: true

class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :year, :rating
  has_many :category
end
