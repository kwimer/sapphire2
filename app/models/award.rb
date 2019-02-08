class Award < ApplicationRecord

  belongs_to :movie
  belongs_to :festival

  attr_accessor :tmdb_import_id
  normalize_attributes :award_type, :award_name

  validates_presence_of :year, :tmdb_import_id
  before_validation :import_media, on: :create

  def name
    "#{year} #{award_name} #{award_type}"
  end

  def tmdb_import_id
    @tmdb_import_id || movie.try(:tmdb_import_id)
  end

  def import_media
    self.movie = Movie.import(tmdb_import_id)
  end

end