# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  def create
    movie = Movie.create!(movie_params)
    if movie.save
      render json: MovieSerializer.new(movie)
    else
      render jsonapi_errors: movie.errors
    end
  end

  def index
    render json: MovieSerializer.new(Movie.all)
  end

  private
  def movie_params
    # whitelist params
    params.require(:_jsonapi)
    .require(:data)
    .require(:attributes)
    .permit(:name, :description, :year)
  end
end