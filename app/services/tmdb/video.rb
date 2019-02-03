module Tmdb
  module Video

    MAPPING = {
      id: :tmdb_id,
      iso_639_1: :language,
      iso_3166_1: nil,
      key: :key,
      name: :name,
      site: :source,
      size: :size,
      type: :video_type
    }

    def self.add(media, data)
      # Import Video
      video = ::Video.where(source: data['site'], key: data['key']).first_or_initialize
      video.media = media
      MAPPING.each { |key, col| video.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      video.save!

      return video
    end

  end
end