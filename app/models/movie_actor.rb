# frozen_string_literal: true

class MovieActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
  validates :movie_id, uniqueness: { scope: :actor_id }
end
