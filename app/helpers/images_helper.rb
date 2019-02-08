module ImagesHelper

  def tmdb_image_tag(media, type, options = {})
    image_tag media.tmdb_image_path(type), options.merge(alt: media.name)
  end

end