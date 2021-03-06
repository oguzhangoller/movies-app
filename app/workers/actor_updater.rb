# frozen_string_literal: true

module MovieWorker
  class ActorUpdater
    def update
      conn = Faraday.new(url: 'https://api.themoviedb.org')
      Actor.all.order(popularity: :desc).each do |actor|
        next if actor.description.present? || actor.gender.present?
        response = conn.get do |req|
          actor_id = actor.id
          req.url "/3/person/#{actor_id}"
          req.headers['Content-Type'] = 'application/json'
          req.params['api_key'] = 'c782fd67766d1efa7f0e6fb2c38d430f'
        end
        update_actor_attributes(response)
      end
    end

    def update_actor_attributes(response)
      results = JSON.parse(response.body)
      birthday = results['birthday']
      gender = results['gender']
      description = results['biography']
      birth_place = results['place_of_birth']

      actor = Actor.find(actor.id)
      actor.update(gender: gender,
                   description: description,
                   birth_date: birthday,
                   birth_place: birth_place)
    end
  end
end
