class Api::SearchController < Api::ApplicationController

  def index
    klass = case params[:type]
            when 'movie'
              Tmdb::Movie
            else
              Tmdb::Media
            end
    results = klass.search(params[:q])
    render json: results.map {|r| r.as_tmdb_option}
  end

end