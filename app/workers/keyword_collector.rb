# frozen_string_literal: true

module MovieWorker
  class KeywordCollector
    def collect
      conn = Faraday.new(url: 'https://api.themoviedb.org')
      page = 0
      Movie.all.each do |movie|
        page += 1
        movie_id = movie.moviedb_id
        response = conn.get do |req|
          req.url "/3/movie/#{movie_id}/keywords"
          req.headers['Content-Type'] = 'application/json'
          req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
        end
        save_movie_keyword(response)
        break if page > 500
      end
    end

    def save_movie_keyword(response)
      json = JSON.parse(response.body)
      results = json['keywords']
      results.each do |result|
        result_id = result['id'].to_i
        if Keyword.where(id: result_id).empty?
          keyword = Keyword.new(id: result_id, name: result['name'])
          keyword.save!
        end
        if MovieKeyword.where(movie_id: movie.id, keyword_id: result_id).empty?
          movie_keyword = MovieKeyword.new(movie_id: movie.id, keyword_id: result_id)
          movie_keyword.save!
        end
      end
    end
  end
end
