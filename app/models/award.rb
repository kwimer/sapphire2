class Award < ApplicationRecord

  belongs_to :media
  belongs_to :festival

  attr_accessor :tmdb_import_id
  normalize_attributes :award_type, :award_name

  validates :year, presence: true
  validates :tmdb_import_id, presence: true, on: :create
  before_validation :import_media, on: :create

  def name
    "#{year} #{award_name} #{award_type}"
  end

  def tmdb_import_id
    @tmdb_import_id || media.try(:tmdb_import_id)
  end

  def import_media
    self.media = Media.import(tmdb_import_id)
  end

end