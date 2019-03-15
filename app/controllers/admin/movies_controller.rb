class Admin::MoviesController < Admin::ApplicationController

  inherit_resources
  respond_to :js, only: :index
  actions :all, :except => [ :show, :destroy, :new, :create ]

  def page_subtitle
    super || 'Media'
  end

  def search
    @movies = params[:q].try(:strip).blank? ? [] : Movie.search_query(params[:q]).limit(10)
    render json: @movies.map(&:as_option)
  end

  protected

  def collection
    scope = end_of_association_chain
    @movies_filter ||= initialize_filterrific(
        scope,
        params[:movies],
        select_options: {
        },
        ) or return
    @movies ||= @movies_filter.find.page(params[:page]).per(24)
  end

  private

  def movie_params
    params.require(:movie).permit(
        :active, :summary, :detail, :selection, category_ids: []
    )
  end

end