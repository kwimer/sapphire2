class Media < ApplicationRecord

  extend FriendlyId
  extend Mobility

  include Categories
  include Credits
  include ExternalIds
  include ExternalScores
  include Importer
  include PgSearch

  alias_attribute :name, :title
  translates :title, :summary, :detail, :tmdb_summary, :tagline
  normalize_attributes :summary, :detail

  pg_search_scope :search_query,
                  against: :title,
                  using: {
                      tsearch: {
                      tsvector_column: :tsv_title,
                      prefix: true
                      }
                  }

  after_save :set_tsv

  def tmdb_import_id
    "#{type.downcase}_#{tmdb_id}"
  end

  def as_tmdb_option(options={})
    {
        id: tmdb_import_id,
        type: type.downcase,
        image: tmdb_image_path(:poster),
        name: name,
        description: year,
        imported: persisted?
    }
  end

  def set_tsv
    Media.connection.execute("UPDATE media SET tsv_title = to_tsvector('simple', translations->'en'->>'title') WHERE id = '#{id}';")
  end

  def synopsis
    summary || tmdb_summary
  end

  def year
    release_date.year if release_date
  end

end