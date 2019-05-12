# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    render json: MovieSerializer.new(Movie.all)
  end
end