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

    def self.add(media, media_data, type, data)
      # Import Image
      image = ::Image.where(source: 'tmdb', key: data['file_path']).first_or_initialize
      image.media = media
      image.image_type = type
      image.primary = %w(backdrop poster profile still).any?{|image_type| media_data.send(:[], "#{image_type}_path") == data['file_path'] && type == image_type.pluralize}
      MAPPING.each { |key, col| image.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      image.save!

      return image
    end

  end
end