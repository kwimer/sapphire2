module Tmdb

  module Api

    BASE_URL = "https://api.themoviedb.org"
    API_KEY = "f4419b0656f23b5d715f70601dcd3e90"

    class << self

      def movie(id)
        response = get("/3/movie/#{id}", append_to_response: "alternative_titles,credits,external_ids,images,keywords,releases,translations,videos")
      end

      def person(id)
        response = get("/3/person/#{id}", append_to_response: "external_ids,images")
      end

      def series(id)
        get("/3/tv/#{id}", append_to_response: "alternative_titles,content_ratings,credits,external_ids,images,keywords,translations,videos")
      end

      def season(id, season_number)
        get("/3/tv/#{id}/season/#{season_number}", append_to_response: "credits,external_ids,images,videos")
      end

      def episode(id, season_number, episode_number)
        get("/3/tv/#{id}/season/#{season_number}/episode/#{episode_number}", append_to_response: "credits,external_ids,images,videos")
      end

      private

      def get(path, params = {})
        response = client.get(path, params: params.merge(api_key: API_KEY))
        if response.status.success?
          response.parse
        elsif response.status.code == 404
          response.parse
          nil
        else
          raise response.inspect
        end
      end

      def client
        @client ||= HTTP.persistent BASE_URL
      end

    end

  end
end