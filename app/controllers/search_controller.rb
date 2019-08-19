# frozen_string_literal: true

class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  def result
    render json:
    {
      movies: MovieSerializer.new(movie_search_results.order(popularity: :desc).limit(5)),
      actors: ActorSerializer.new(actor_search_results.order(popularity: :desc).limit(5))
    }
  end

  private

  def movie_search_results
    Movie.ransack(name_cont_all: search_params).result
  end

  def actor_search_results
    Actor.ransack(name_cont_all: search_params).result
  end

  def search_params
    params[:query].split(' ')
  end
end
