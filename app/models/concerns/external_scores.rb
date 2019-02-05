module ExternalScores

  extend ActiveSupport::Concern

  included do
    jsonb_accessor :external_scores,
                   tmdb_votes: :integer,
                   tmdb_rating: :float
  end

end
