module Tmdb
  module Episode

    MAPPING = {
      air_date: :start_date,
      episode_number: :number,
      name: :title,
      overview: :tmdb_summary,
      id: :tmdb_id,
      production_code: :production_code,
      season_number: :season_number,
      still_path: :tmdb_still_path,
      vote_average: :tmdb_rating,
      vote_count: :tmdb_votes
    }

    def self.add(series, season, number)

      # Episode Import
      sleep 0.2
      data = Tmdb::Api.episode(series.tmdb_id, season.number, number)
      episode = ::Episode.where(season: season, number: number).first_or_initialize
      MAPPING.each { |key, col| episode.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }

      # External Ids Import
      data['external_ids'].each do |key, val|
        episode.send("#{key}=", val) if val && episode.respond_to?(key)
      end

      episode.save!

      # Credits Import
      data['credits'].each do |type, credits|
        credits.each { |data| Credit.add(series, episode, type, data) }
      end

      # Images Import
      # data['images'].each do |type, images|
      #   images.each { |image| Image.add(episode, data, type, image) }
      # end

      # Videos Import
      # data['videos']['results'].each do |video|
      #   Video.add(episode, video)
      # end

      return episode
    end

  end
end
