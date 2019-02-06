class Movie < Media

  include Importer
  friendly_id :name_with_year

  jsonb_accessor :extra_fields,
                 runtime: :integer,
                 languages: [:string, array: true],
                 countries: [:string, array: true]

  has_many :media_categories, as: :media
    accepts_nested_attributes_for :media_categories, reject_if: :all_blank, allow_destroy: true
  has_many :categories, through: :media_categories

  def name_with_year
    "#{title} (#{year})"
  end

  def year
    start_date.year
  end

end
