module Tmdb
  module Movie

    MAPPING = {
      adult: :adult,
      backdrop_path: nil,
      belongs_to_collection: nil,
      budget: nil,
      genres: {
        id: nil,
        name: :name
      },
      homepage: nil,
      id: :tmdb_id,
      imdb_id: :imdb_id,
      original_language: :original_language,
      original_title: :original_title,
      overview: :summary,
      popularity: nil,
      poster_path: nil,
      production_companies: {
        id: :tmdb_id,
        logo_path: nil,
        name: nil,
        origin_country: nil
      },
      production_countries: {
        iso_3166_1: nil,
        name: nil
      },
      release_date: :start_date,
      revenue: nil,
      runtime: :runtime,
      spoken_languages: {
        iso_639_1: nil,
        name: nil
      },
      status: :status,
      tagline: :tagline,
      title: :title,
      video: nil,
      vote_average: :tmdb_vote_average,
      vote_count: :tmdb_vote_count
    }

    def self.import(id)

      # Movie Import
      sleep 0.2
      data = Tmdb::Api.movie(id)
      movie = ::Movie.external_ids_where(tmdb_id: id.to_s).first_or_initialize
      MAPPING.each { |key, col| movie.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      movie.save!

      # External Ids Import
      data['external_ids'].each do |key, val|
        movie.send("#{key}=", val) if val && movie.respond_to?(key)
      end

      # Images Import
      data['images'].each do |type, images|
        images.each { |image| Image.add(movie, data, type, image) }
      end

      # Videos Import
      data['videos']['results'].each do |video|
        Video.add(movie, video)
      end

      # Credits Import
      data['credits'].each do |type, credits|
        credits.each { |data| Credit.add(movie, movie, type, data) }
      end

      return movie
    end

  end
end