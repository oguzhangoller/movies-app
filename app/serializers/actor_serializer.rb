# frozen_string_literal: true

class ActorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :popularity, :poster_path
  has_many :movies
end
