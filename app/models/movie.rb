class Movie < Media

  include Categories
  include Importer
  friendly_id :name_with_year

  jsonb_accessor :extra_fields,
                 runtime: :integer,
                 languages: [:string, array: true],
                 countries: [:string, array: true]

  scope :search_query, -> (q) {
    q = Textacular.to_query(q)
    advanced_search({original_title: q}, false)
  }

  def as_option(options={})
    {
        id: id,
        image: "https://image.tmdb.org/t/p/w370_and_h556_bestv2#{tmdb_poster_path}",
        name: name,
        description: year,
    }
  end

  def name_with_year
    "#{title} (#{year})"
  end

  def year
    start_date.year
  end

end
