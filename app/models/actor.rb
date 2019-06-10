class Actor < ApplicationRecord
  has_many :movie_actors, foreign_key: :actor_id, dependent: :destroy
  has_many :movies, through: :movie_actors

  validates :name, presence: true
end