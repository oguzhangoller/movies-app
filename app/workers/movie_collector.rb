# frozen_string_literal: true

module MovieWorker
  class MovieCollector
    def collect(year)
      conn = Faraday.new(:url => 'https://api.themoviedb.org')
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
        json = JSON.parse(response.body)
        results = json["results"]
        results.each do |result|
          begin
            m = Movie.new(name:result["title"], 
                          rating: result["vote_average"],
                          language: result["original_language"],
                          poster_path: result["poster_path"],
                          popularity: result["popularity"],
                          year: result["release_date"][0,4],
                          moviedb_id: result["id"],
                          description: result["overview"])
            m.save
            movieId = m.id
            genres = result['genre_ids']
            genres.each do |genreId|
              mc = MovieCategory.create(movie_id: movieId, category_id: genreId)
              mc.save
            end
          rescue
            next
          end
        end
        break unless page < 200
      end
    end
  end
end
