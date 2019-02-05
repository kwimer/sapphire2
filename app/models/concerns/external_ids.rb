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

end
