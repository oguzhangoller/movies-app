# frozen_string_literal: true

class MovieService::SimilarMovies
  def call(moviedb_id)
    response = request_for_similar_movies(moviedb_id)
    movie_id_list = get_movie_ids_from_response(response)
    movies = collect_movies_from_database(movie_id_list)
    movies
  end

  def request_for_similar_movies(moviedb_id)
    conn = Faraday.new(url: 'https://api.themoviedb.org')
    response = conn.get do |req|
      req.url "/3/movie/#{moviedb_id}/similar"
      req.headers['Content-Type'] = 'application/json'
      req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
      req.params['page'] = 1
    end
    response
  end

  def get_movie_ids_from_response(response)
    json = JSON.parse(response.body)
    movie_ids = json['results'].map { |result| result['id'] }
    movie_ids
  end

  def collect_movies_from_database(movie_id_list)
    movies = []
    movie_id_list.each do |id|
      movie = Movie.where(moviedb_id: id).first
      movies.push(movie) if movie
    end
    movies
  end
end
