class ListItem < ApplicationRecord

  belongs_to :list, counter_cache: true
  belongs_to :media

  acts_as_list scope: :list

  attr_accessor :tmdb_import_id
  normalize_attributes :detail

  validates :tmdb_import_id, presence: true, on: :create
  before_validation :import_media, on: :create

  def import_media
    self.media = Media.import(tmdb_import_id)
  end

  def name
    "#{position}. #{media.name}"
  end

end