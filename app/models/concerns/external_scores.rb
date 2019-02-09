module ExternalScores

  extend ActiveSupport::Concern

  included do
    jsonb_accessor :external_scores,
                   imdb_rating: :float,
                   imdb_votes: :integer,
                   metacritic_rating: :integer,
                   rt_rating: :integer,
                   tmdb_rating: :float,
                   tmdb_votes: :integer


    def import_scores
      return unless imdb_id
      data = Omdb::Api.find(imdb_id)
      return unless data
      self.imdb_rating = data['imdbRating']
      self.imdb_votes = data['imdbVotes']
      self.metacritic_rating = data['Metascore']
      self.rt_rating = data['Ratings'].find{|r| r['Source'] == 'Rotten Tomatoes'}.try(:[], 'Value')
      return data
    end

    def import_scores!
      import_scores
      save
    end

  end

end

# {
#    "Title":"The Avengers",
#    "Year":"2012",
#    "Rated":"PG-13",
#    "Released":"04 May 2012",
#    "Runtime":"143 min",
#    "Genre":"Action, Adventure, Sci-Fi",
#    "Director":"Joss Whedon",
#    "Writer":"Joss Whedon (screenplay), Zak Penn (story), Joss Whedon (story)",
#    "Actors":"Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth",
#    "Plot":"Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.",
#    "Language":"English, Russian, Hindi",
#    "Country":"USA",
#    "Awards":"Nominated for 1 Oscar. Another 38 wins & 79 nominations.",
#    "Poster":"https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
#    "Ratings":[
#       {
#          "Source":"Internet Movie Database",
#          "Value":"8.1/10"
#       },
#       {
#          "Source":"Rotten Tomatoes",
#          "Value":"92%"
#       },
#       {
#          "Source":"Metacritic",
#          "Value":"69/100"
#       }
#    ],
#    "Metascore":"69",
#    "imdbRating":"8.1",
#    "imdbVotes":"1,144,824",
#    "imdbID":"tt0848228",
#    "Type":"movie",
#    "DVD":"25 Sep 2012",
#    "BoxOffice":"$623,279,547",
#    "Production":"Walt Disney Pictures",
#    "Website":"http://marvel.com/avengers_movie",
#    "Response":"True"
# }