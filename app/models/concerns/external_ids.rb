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
                   twitter_id: :string,
                   youtube_trailer_id: :string
  end

  def tmdb_image_path(type)
    image_path = send("tmdb_#{type}_path")
    return ActionController::Base.helpers.image_path("defaults/#{self.class.name.underscore}_#{type}.jpg") unless image_path
    size = case type.to_sym
           when :profile
             'w276_and_h350_face'
           when :poster
             'w370_and_h556_bestv2'
           when :still
             'w227_and_h127_bestv2'
           when :backdrop
             'w1280'
           end if size.nil?
    "https://image.tmdb.org/t/p/#{size}#{image_path}"
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
