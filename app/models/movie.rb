class Movie < Media

  include Categories
  include Importer
  friendly_id :name_with_year

  jsonb_accessor :extra_fields,
                 runtime: :integer,
                 languages: [:string, array: true],
                 countries: [:string, array: true]

  def name_with_year
    "#{title} (#{year})"
  end

  def year
    start_date.year
  end

end
