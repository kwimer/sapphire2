module Tmdb
  module Season

    MAPPING = {
      _id: nil,
      air_date: :start_date,
      episodes: {
        air_date: nil,
        episode_number: nil,
        id: nil,
        name: nil,
        overview: nil,
        production_code: nil,
        season_number: nil,
        show_id: nil,
        still_path: nil,
        vote_average: nil,
        vote_count: nil,
      },
      name: :title,
      overview: :tmdb_summary,
      id: :tmdb_id,
      poster_path: :tmdb_poster_path,
      season_number: :number
    }

    def self.add(series, number)

      # Seasons Import
      sleep 0.1
      data = Tmdb::Api.season(series.tmdb_id, number)
      season = ::Season.where(series: series, number: number).first_or_initialize
      MAPPING.each { |key, col| season.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }

      # External Ids Import
      data['external_ids'].each do |key, val|
        season.send("#{key}=", val) if val && season.respond_to?(key)
      end

      season.save!

      # Images Import
      # data['images'].each do |type, images|
      #   images.each { |image| Image.add(season, data, type, image) }
      # end

      # Videos Import
      # data['videos']['results'].each do |video|
      #   Video.add(season, video)
      # end

      # Credits Import
      data['credits'].each do |type, credits|
        credits.each { |data| Credit.add(series, season, type, data) }
      end

      # Episodes Import
      data['episodes'].each do |episode|
        Episode.add(series, season, episode['episode_number'])
      end

      return season
    end

  end
end