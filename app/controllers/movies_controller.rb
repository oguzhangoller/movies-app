# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  def create
    movie = Movie.create!(movie_create_params)
    category_params.each do |category_id|
      MovieCategory.create!(movie_id: movie.id, category_id: category_id)
    end
    if movie.save
      render json: MovieSerializer.new(movie)
    else
      render jsonapi_errors: movie.errors
    end
  end

  def show
    movie = Movie.find(params[:id])
    render json: MovieSerializer.new(movie)
  end

  def index
    per_page = params[:per_page] || 20
    page = params[:page] || 1
    options = {}
    options[:meta] = {
      page: page,
      total_pages:  Movie.all.count / per_page.to_i + 1, 
    }
    render json: MovieSerializer.new(Movie.all
                                          .page(page)
                                          .per(per_page), options)
  end

  def recommended_movies
    movies = MovieService::RecommendedMovies.new.call(moviedb_id)
    render json: MovieSerializer.new(movies.first(3))
  end

  def similar_movies
    movies = MovieService::SimilarMovies.new.call(moviedb_id)
    render json: MovieSerializer.new(movies.first(3))
  end

  private

  def movie_create_params
    params.require(:_jsonapi)
    .require(:data)
    .require(:attributes)
    .permit(:name, :description, :year, :rating)
  end

  def category_params
    id_array = []
    params.require(:_jsonapi)
    .require(:data)
    .require(:relationships)
    .require(:categories)
    .require(:data).each do |obj|
      id_array.push(obj[:id]) 
    end
    id_array
  end

  def moviedb_id
    Movie.find(params[:id]).moviedb_id
  end
end