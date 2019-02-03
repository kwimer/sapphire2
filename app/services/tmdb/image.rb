module Tmdb
  module Image

    MAPPING = {
      aspect_ratio: nil,
      file_path: :key,
      height: :height,
      iso_639_1: :language,
      vote_average: nil,
      vote_count: nil,
      width: :width
    }

    def self.add(media, type, data)
      # Import Image
      image = ::Image.where(source: 'tmdb', key: data['file_path']).first_or_initialize
      image.media = media
      image.image_type = type
      image.primary = (data['poster_path'] == data['key'] && type == 'posters') || (data['backdrop_path'] == data['key'] && type == 'backdrops') || (data['profile_path'] == data['key'] && type == 'profiles')
      MAPPING.each { |key, col| image.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      image.save!

      return image
    end

  end
end