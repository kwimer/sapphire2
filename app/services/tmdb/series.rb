module Tmdb
  module Series

    MAPPING = {
      backdrop_path: nil,
      created_by: {
        id: :tmdb_id,
        credit_id: nil,
        name: :title,
        profile_path: nil
      },
      episode_run_time: nil,
      first_air_date: :start_date,
      genres: {
        id: :tmdb_id,
        name: :name
      },
      homepage: nil,
      id: :tmdb_id,
      in_production: :in_production,
      languages: nil,
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
      origin_country: nil,
      original_language: :original_language,
      original_name: :original_title,
      overview: :summary,
      popularity: nil,
      poster_path: nil,
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
        overview: :summary,
        poster_path: nil,
        season_number: :number
      },
      status: :status,
      type: :media_type,
      vote_average: nil,
      vote_count: nil
    }

    def self.import(id)

      # Series Import
      sleep 0.2
      data = Tmdb::Api.series(id)
      series = ::Series.external_ids_where(tmdb_id: id.to_s).first_or_initialize
      MAPPING.each { |key, col| series.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      series.save!

      # External Ids Import
      data['external_ids'].each do |key, val|
        series.send("#{key}=", val) if val && series.respond_to?(key)
      end

      # Images Import
      data['images'].each do |type, images|
        images.each { |image| Image.add(series, data, type, image) }
      end

      # Videos Import
      data['videos']['results'].each do |video|
        Video.add(series, video)
      end

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