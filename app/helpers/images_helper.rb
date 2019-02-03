module ImagesHelper

  def tmdb_image_tag(image, options = {})
    return unless image
    image_tag tmdb_image_src(image), options.merge(alt: image.media.name)
  end

  def tmdb_image_src(image)
    return unless image
    size = case image.image_type
           when 'profiles'
             'w138_and_h175_face'
           when 'posters'
             'w370_and_h556_bestv2'
           when 'stills'
             'w227_and_h127_bestv2'
           when 'backdrops'
             'w1280'
           end if size.nil?
    "https://image.tmdb.org/t/p/#{size}#{image.key}"
  end

end