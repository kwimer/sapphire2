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
  #
  def imdb_image_tag(image, options = {})
    return unless image
    image_tag imdb_image_src(image), options.merge(alt: image.media.name)
  end

  def imdb_image_src(image)
    return unless image
    size = case image.image_type
           when 'profiles'
             'w185'
           when 'posters'
             'w92'
           when 'stills'
             'w227_and_h127_bestv2'
           when 'backdrops'
             'w1280'
           end if size.nil?
    "https://image.tmdb.org/t/p/#{size}#{image.key}"
  end

  def still_tag(media)
    image_tag"https://image.tmdb.org/t/p/w92#{media.still.key}", alt: media.title if media.still
  end

  def backdrop_tag(media)
    image_tag"https://image.tmdb.org/t/p/w780#{media.backdrop.key}", alt: media.title if media.backdrop
  end

  def poster_tag(media, options = {})
    image_tag"https://image.tmdb.org/t/p/w92#{media.poster.key}", options.merge(alt: media.title) if media.poster
  end

end