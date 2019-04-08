class Episode < ApplicationRecord

  alias_attribute :name, :title

  extend FriendlyId
  extend Mobility

  include Credits
  include ExternalIds
  include ExternalScores

  translates :title, :summary, :tmdb_summary
  normalize_attributes :summary, :detail

  normalize_attributes :production_code
  friendly_id :episode_code

  jsonb_accessor :extra_fields,
                 runtime: :integer,
                 production_code: :string

  belongs_to :series
  belongs_to :season

  def episode_code
    "S#{'%02i' % season_number}E#{'%02i' % number} #{title}"
  end

end
