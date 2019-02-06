class Series < Media

  include Categories
  include Importer
  friendly_id :name

  jsonb_accessor :extra_fields,
                 in_production: :boolean,
                 episode_runtimes: [:integer, array: true],
                 languages: [:string, array: true],
                 countries: [:string, array: true]

  has_many :seasons, -> { order(:number) }
  has_many :episodes, through: :seasons

end
