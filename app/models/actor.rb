# frozen_string_literal: true

class Actor < ApplicationRecord
  has_many :movie_actors, foreign_key: :actor_id, dependent: :destroy, inverse_of: false
  has_many :movies, through: :movie_actors

  validates :name, presence: true
end
