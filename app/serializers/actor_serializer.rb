# frozen_string_literal: true

class ActorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :popularity, :poster_path, :description, :birth_place, :birth_date
  has_many :movies do |object|
    object.movies.order(popularity: :desc).limit(6)
  end
end
