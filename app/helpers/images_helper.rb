module ImagesHelper

  def tmdb_image_tag(media, type, options = {})
    image_path = media.tmdb_image_path(type)
    image_tag image_path, options.merge(alt: media.name) if image_path
  end

end