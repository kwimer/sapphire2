module Omdb

  module Api

    #http://www.omdbapi.com/?i=tt3896198&apikey=xxx

    BASE_URL = "http://www.omdbapi.com"
    API_KEY = ENV["OMDB_API_KEY"]

    class << self

      def movie(imdb_id)
        response = get("/", i: imdb_id)
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