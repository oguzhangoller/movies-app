# frozen_string_literal: true

module MovieWorker
  class ActorCollector
    def collect
      conn = Faraday.new(url: 'https://api.themoviedb.org')
      page = 0
      loop do
        page += 1
        response = conn.get do |req|
          req.url '/3/person/popular'
          req.headers['Content-Type'] = 'application/json'
          req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
          req.params['page'] = page
        end
        save_actor(response)
        break unless page < 50
      end
    end

    def save_actor(response)
      json = JSON.parse(response.body)
      results = json['results']
      results.each do |result|
        id = result['id']
        name = result['name']
        popularity = result['popularity']
        poster_path = result['profile_path']
        begin
          ac = Actor.new(id: id, name: name, popularity: popularity, poster_path: poster_path)
          ac.save!
        rescue StandardError
          next
        end
      end
    end
  end
end
