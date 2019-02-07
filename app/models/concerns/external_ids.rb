module ExternalIds

  extend ActiveSupport::Concern

  included do
    jsonb_accessor :external_ids,
                   facebook_id: :string,
                   imdb_id: :string,
                   instagram_id: :string,
                   tmdb_id: :string,
                   tmdb_backdrop_path: :string,
                   tmdb_poster_path: :string,
                   tmdb_profile_path: :string,
                   tmdb_still_path: :string,
                   tvdb_id: :string,
                   twitter_id: :string
  end

  def tmdb_url
    case type
    when 'Movie'
      "https://www.themoviedb.org/movie/#{tmdb_id}"
    when 'Series'
      "https://www.themoviedb.org/tv/#{tmdb_id}"
    when 'Season'
      "https://www.themoviedb.org/tv/#{series.tmdb_id}/season/#{number}"
    when 'Episode'
      "https://www.themoviedb.org/tv/#{series.tmdb_id}/season/#{number}"
    end

  end

end
