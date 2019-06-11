# frozen_string_literal: true

class ActorsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def create
    actor = Actor.create!(actor_create_params)
    if actor.save
      render json: ActorSerializer.new(actor)
    else
      render jsonapi_errors: actor.errors
    end
  end

  def show
    actor = Actor.find(params[:id])
    render json: ActorSerializer.new(actor)
  end

  def index
    per_page = params[:per_page] || 20
    page = params[:page] || 1
    options = {}
    options[:meta] = {
      page: page,
      total_pages:  Actor.all.count / per_page.to_i + 1, 
    }
    render json: ActorSerializer.new(Actor.all
                                          .page(page)
                                          .per(per_page), options)
  end

  private

  def actor_create_params
    params.require(:_jsonapi)
    .require(:data)
    .require(:attributes)
    .permit(:name, :popularity, :poster_path)
  end
end