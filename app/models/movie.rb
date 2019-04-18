class Movie < Media

  friendly_id :name_with_year

  jsonb_accessor :extra_fields,
                 original_title: :string,
                 original_language: :string,
                 rating: :string,
                 runtime: :integer,
                 languages: [:string, array: true],
                 countries: [:string, array: true]


  filterrific(
      #default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :page,
          #:sorted_by,
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

  def details
    [rating, year, runtime ? "#{runtime} minutes" : nil].compact.join(' | ')
  end

  def name_with_year
    "#{title} (#{year})"
  end

end
