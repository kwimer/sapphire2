class Admin::MoviesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy, :new, :create ]

  def page_subtitle
    super || 'Media'
  end

  def search
    @movies = params[:q].try(:strip).blank? ? [] : Movie.search_query(params[:q]).limit(10)
    render json: @movies.map(&:as_option)
  end

  private

  def movie_params
    params.require(:movie).permit(
        :active, :summary, :detail, category_ids: []
    )
  end

end