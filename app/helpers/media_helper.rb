module MediaHelper

  def media_details(media)
    case media.type
    when 'Movie'
      [media.rating, media.year, "#{media.runtime} minutes"].compact.join(' | ')
    else
      [media.rating, media.year, pluralize(media.seasons_count, 'season'), pluralize(media.episodes_count, 'episode')].compact.join(' | ')
    end

  end
end