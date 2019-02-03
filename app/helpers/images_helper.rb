module ImagesHelper

  # {
  #   base_url: "https://image.tmdb.org/t/p/",
  #   backdrop_sizes: [
  #     "w300",
  #     "w780",
  #     "w1280",
  #     "original"
  #   ],
  #   logo_sizes: [
  #     "w45",
  #     "w92",
  #     "w154",
  #     "w185",
  #     "w300",
  #     "w500",
  #     "original"
  #   ],
  #   poster_sizes: [
  #     "w92",
  #     "w154",
  #     "w185",
  #     "w342",
  #     "w500",
  #     "w780",
  #     "original"
  #   ],
  #   profile_sizes: [
  #     "w45",
  #     "w185",
  #     "h632",
  #     "original"
  #   ],
  #   still_sizes: [
  #     "w92",
  #     "w185",
  #     "w300",
  #     "original"
  #   ]
  # }
  #

  def still_tag(media)
    image = media.images.where(image_type: 'still').first
    image_tag"https://image.tmdb.org/t/p/w92#{image.key}", alt: media.title if image
  end

  def backdrop_tag(media)
    image = media.images.where(image_type: 'backdrops').first
    image_tag"https://image.tmdb.org/t/p/w780#{image.key}", alt: media.title if image
  end

  def poster_tag(media, options = {})
    image = media.images.where(image_type: 'posters').first
    image_tag"https://image.tmdb.org/t/p/w92#{image.key}", options.merge(alt: media.title)
  end

end