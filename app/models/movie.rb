class Movie < Media

  include Categories
  include Importer
  friendly_id :name_with_year

  jsonb_accessor :extra_fields,
                 original_title: :string,
                 original_language: :string,
                 runtime: :integer,
                 languages: [:string, array: true],
                 countries: [:string, array: true]


  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :search_query
      ]
  )

  scope :sorted_by, ->(sort_option) {
    #return unless options_for_sorted_by.map(&:last).include?(sort_option)
    sort, delim, direction = sort_option.rpartition('_')
    case sort
    when 'derp'
    else
      order(Hash[sort, direction])
    end
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
