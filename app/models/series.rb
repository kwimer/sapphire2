class Series < Media

  friendly_id :name

  jsonb_accessor :extra_fields,
                 original_title: :string,
                 original_language: :string,
                 media_type: :string,
                 seasons_count: :integer,
                 episodes_count: :integer,
                 rating: :string,
                 in_production: :boolean,
                 episode_runtimes: [:integer, array: true],
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

  has_many :seasons#, -> { order(:number) }
  has_many :episodes, through: :seasons

  def details
    [rating, year, ActionController::Base.helpers.pluralize(seasons_count, 'season'), ActionController::Base.helpers.pluralize(episodes_count, 'episode')].compact.join(' | ')
  end

end
