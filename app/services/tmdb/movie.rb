module Tmdb
  module Movie

    MAPPING = {
      adult: nil,
      backdrop_path: :tmdb_backdrop_path,
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
      overview: :tmdb_summary,
      popularity: nil,
      poster_path: :tmdb_poster_path,
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
      release_date: :release_date,
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
      vote_average: :tmdb_rating,
      vote_count: :tmdb_votes
    }

    def self.import(id, full_import = false)

      # Movie Import
      sleep 0.2
      data = Tmdb::Api.movie(id)
      return if data.nil? || data['adult']
      movie = ::Movie.external_ids_where(tmdb_id: id.to_s).first_or_initialize
      MAPPING.each { |key, col| movie.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      movie.languages = data['spoken_languages'].map{|l| l['iso_639_1']}
      movie.countries = data['production_countries'].map{|l| l['iso_3166_1']}

      # External Ids Import
      data['external_ids'].each do |key, val|
        movie.send("#{key}=", val) if val && movie.respond_to?(key)
      end

      # Trailer
      trailer = data['videos']['results'].find {|result| result['type'] == "Trailer" && result['site'] = 'YouTube'}
      movie.youtube_trailer_id = trailer['key'] if trailer

      # Rating
      release = data['release_dates']['results'].find {|result| result['iso_3166_1'] == "US"}
      rating = release['release_dates'].find {|result| !result['certification'].blank? }
      movie.rating = rating['certification'] if rating

      movie.save!

      # Genres
      genre_category = ::Category.root.where(code: 'genre').first_or_create!(name: 'Genre')
      data['genres'].each do |genre|
        category = ::Category.where(parent: genre_category, name: genre['name']).first_or_create!
        ::MediaCategory.where(category: category, media: movie).first_or_create!
      end

      return movie unless full_import

      # Images Import
      # data['images'].each do |type, images|
      #   images.each { |image| Image.add(movie, data, type, image) }
      # end

      # Videos Import
      # data['videos']['results'].each do |video|
      #   Video.add(movie, video) if video['type']
      # end

      # Credits Import
      data['credits'].each do |type, credits|
        credits.each { |data| Credit.add(movie, movie, type, data) }
      end

      return movie
    end

  end
end