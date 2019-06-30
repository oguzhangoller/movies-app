# frozen_string_literal: true

class MovieService::ActorMovies
  def call(actor_id)
    MovieActor.where(actor_id: actor_id)
  end
end
