class Media < ApplicationRecord

  extend FriendlyId
  extend Mobility

  include ExternalIds
  include ExternalScores
  include PgSearch

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

  has_many :media_categories
  has_many :categories, through: :media_categories

  has_many :media_credits, as: :media
  has_many :credits, through: :media_credits

  after_save :set_tsv

  def name
    title
  end

  def set_tsv
    Media.connection.execute("UPDATE media SET tsv_title = to_tsvector('simple', translations->'en'->>'title') WHERE id = '#{id}';")
  end

  def synopsis
    summary || tmdb_summary
  end

  def year
    start_date.year if start_date
  end

end