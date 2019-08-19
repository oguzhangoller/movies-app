# frozen_string_literal: true

module MovieWorker
  class MovieActorCollector
    def collect
      conn = Faraday.new(url: 'https://api.themoviedb.org')
      movie_count = 0
      Movie.order(popularity: :desc).each do |movie|
        movie_count += 1
        movie_id = movie.moviedb_id
        response = conn.get do |req|
          req.url "/3/movie/#{movie_id}/credits"
          req.headers['Content-Type'] = 'application/json'
          req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
        end
        save_movie_actor(response)
        break unless movie_count < 15_000
      end
    end

    def save_movie_actor(response)
      json = JSON.parse(response.body)
      results = json['cast']
      counter = 0
      results.each do |result|
        counter += 1
        begin
          movie_actor = MovieActor.new(movie_id: movie.id, actor_id: result['id'])
          movie_actor.save!
        rescue StandardError
          next
        end
        break unless counter < 3
      end
    end
  end
end
