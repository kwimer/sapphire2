module ExternalFields

  extend ActiveSupport::Concern

  included do
    jsonb_accessor :external_ids,
                   facebook_id: :string,
                   imdb_id: :string,
                   instagram_id: :string,
                   tmdb_id: :string,
                   tvdb_id: :string,
                   twitter_id: :string

    jsonb_accessor :external_scores,
                   tmdb_vote_count: :float,
                   tmdb_vote_average: :float
  end

end
