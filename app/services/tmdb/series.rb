module Tmdb
  module Series

    MAPPING = {
      backdrop_path: :tmdb_backdrop_path,
      created_by: {
        id: :tmdb_id,
        credit_id: nil,
        name: :title,
        profile_path: nil
      },
      episode_run_time: :episode_runtimes,
      first_air_date: :start_date,
      genres: {
        id: nil,
        name: :name
      },
      homepage: nil,
      id: :tmdb_id,
      in_production: :in_production,
      languages: :languages,
      last_air_date: :end_date,
      last_episode_to_air: nil,
      name: :title,
      next_episode_to_air: nil,
      networks: {
        name: :name,
        id: :tmdb_id,
        logo_path: nil,
        origin_country: nil
      },
      number_of_episodes: nil,
      number_of_seasons: nil,
      origin_country: :countries,
      original_language: :original_language,
      original_name: :original_title,
      overview: :tmdb_summary,
      popularity: nil,
      poster_path: :tmdb_poster_path,
      production_companies: {
        id: :tmdb_id,
        logo_path: nil,
        name: :name,
        origin_country: :original_country
      },
      seasons: {
        air_date: :air_date,
        episode_count: :episode_count,
        id: :tmdb_id,
        name: :name,
        overview: :tmdb_summary,
        poster_path: nil,
        season_number: :number
      },
      status: :status,
      type: :media_type,
      vote_average: :tmdb_rating,
      vote_count: :tmdb_votes
    }

    def self.import(id)

      # Series Import
      sleep 0.2
      data = Tmdb::Api.series(id)
      return if data.nil?
      series = ::Series.external_ids_where(tmdb_id: id.to_s).first_or_initialize
      MAPPING.each { |key, col| series.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }

      # External Ids Import
      data['external_ids'].each do |key, val|
        series.send("#{key}=", val) if val && series.respond_to?(key)
      end

      # Rating
      rating = data['content_ratings']['results'].find {|result| result['iso_3166_1'] == "US"}
      series.rating = rating['rating'] if rating

      series.save!

      # Genres
      genre_category = ::Category.root.where(code: 'genre').first_or_create!(name: 'Genre')
      data['genres'].each do |genre|
        category = ::Category.where(parent: genre_category, name: genre['name']).first_or_create!
        ::MediaCategory.where(category: category, media: series).first_or_create!
      end

      # Images Import
      # data['images'].each do |type, images|
      #   images.each { |image| Image.add(series, data, type, image) }
      # end

      # Videos Import
      # data['videos']['results'].each do |video|
      #   Video.add(series, video)
      # end

      # Credits Import
      data['credits'].each do |type, credits|
        credits.each { |data| Credit.add(series, series, type, data) }
      end

      # Seasons Import
      data['seasons'].each do |season|
        Season.add(series, season['season_number'])
      end

      return series
    end

  end
end