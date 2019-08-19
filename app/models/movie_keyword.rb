# frozen_string_literal: true

class MovieKeyword < ApplicationRecord
  belongs_to :movie
  belongs_to :keyword
end
