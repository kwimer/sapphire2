module Omdb

  module Api

    BASE_URL = "http://www.omdbapi.com"
    API_KEY = ENV["OMDB_API_KEY"]

    class << self

      # http://www.omdbapi.com/?i=tt3896198&apikey=xxx
      def find(imdb_id)
        get("/", i: imdb_id)
      end

      # http://www.omdbapi.com/?t=avengers&y=2018
      def search(query, year = nil)
        get("/", {t: query, y: year}.compact)
      end

      private

      def get(path, params = {})
        response = client.get(path, params: params.merge(apikey: API_KEY))
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