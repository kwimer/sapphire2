module Tmdb
  module Media

    def self.search(q)
      return [] if q.blank?
      response = Tmdb::Api.search(q)
      results = []
      response['results'].each do |data|
        case data['media_type']
        when 'movie', 'tv'
          class_name = data['media_type'] == 'movie' ? 'Movie' : 'Series'
          media = class_name.classify.constantize.send(:external_ids_where, tmdb_id: data['id'].to_s).first_or_initialize
          "tmdb/#{class_name}".classify.constantize.const_get('MAPPING').each { |key, col| media.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
          results << media
        end
      end
      results
    end

  end
end
