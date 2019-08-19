# frozen_string_literal: true

module MovieWorker
  class MovieCollector
    def collect(year)
      conn = Faraday.new(url: 'https://api.themoviedb.org')
      page = 0
      loop do
        page += 1
        response = conn.get do |req|
          req.url '/3/discover/movie'
          req.headers['Content-Type'] = 'application/json'
          req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
          req.params['sort_by'] = 'popularity.desc'
          req.params['primary_release_year'] = year.to_s
          req.params['page'] = page
        end
        create_movie_and_movie_category(response)
        break unless page < 200
      end
    end

    private

    def create_movie_and_movie_category(response)
      json = JSON.parse(response.body)
      results = json['results']
      results.each do |result|
        begin
          movie.assign_attributes(movie_attributes)
          movie = create_movie(result)
          create_movie_categories(result, movie.id)
        rescue StandardError
          next
        end
      end
    end

    def create_movie_categories(result, movie_id)
      genres = result['genre_ids']
      genres.each do |genre_id|
        movie_category = MovieCategory.create(movie_id: movie_id, category_id: genre_id)
        movie_category.save
      end
    end

    def create_movie(result)
      movie = Movie.new(name: result['title'],
                        rating: result['vote_average'],
                        language: result['original_language'],
                        poster_path: result['poster_path'],
                        popularity: result['popularity'],
                        year: result['release_date'][0, 4],
                        moviedb_id: result['id'],
                        description: result['overview'])
      movie.save
      movie
    end
  end
end
