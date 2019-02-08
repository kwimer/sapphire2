class Award < ApplicationRecord

  belongs_to :movie
  belongs_to :festival

  attr_accessor :tmdb_movie_id

  validates_presence_of :year, :tmdb_movie_id
  before_validation :import_movie, on: :create

  def name
    "#{year} #{award_name} #{award_type}"
  end

  def tmdb_movie_id
    @tmdb_id || movie.try(:tmdb_import_id)
  end

  def import_movie
    if tmdb_movie_id
      model, delim, tmdb_id = tmdb_movie_id.rpartition('/')
      self.movie = model.classify.constantize.send(:import, tmdb_id)
      movie.import if movie
    end
  end

end