# frozen_string_literal: true

class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  def index
    render json: CategorySerializer.new(Category.all)
  end

  def show
    render json: CategorySerializer.new(Category.find(params[:id]))
  end
end
