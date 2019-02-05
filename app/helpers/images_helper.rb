module ImagesHelper

  def tmdb_image_tag(media, type, options = {})
    image_path = media.send("tmdb_#{type}_path")
    return unless image_path
    image_tag tmdb_image_src(image_path, type), options.merge(alt: media.name)
  end

  def tmdb_image_src(image_path, type)
    return unless image_path
    size = case type.to_sym
           when :profile
             'w138_and_h175_face'
           when :poster
             'w370_and_h556_bestv2'
           when :still
             'w227_and_h127_bestv2'
           when :backdrop
             'w1280'
           end if size.nil?
    "https://image.tmdb.org/t/p/#{size}#{image_path}"
  end

  # def tmdb_image_tag(image, options = {})
  #   return unless image
  #   image_tag tmdb_image_src(image), options.merge(alt: image.media.name)
  # end
  #
  # def tmdb_image_src(image)
  #   return unless image
  #   size = case image.image_type
  #          when 'profiles'
  #            'w138_and_h175_face'
  #          when 'posters'
  #            'w370_and_h556_bestv2'
  #          when 'stills'
  #            'w227_and_h127_bestv2'
  #          when 'backdrops'
  #            'w1280'
  #          end if size.nil?
  #   "https://image.tmdb.org/t/p/#{size}#{image.key}"
  # end

end