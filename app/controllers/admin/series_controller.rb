class Admin::SeriesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy, :new, :create ]

  def page_subtitle
    super || 'Media'
  end

  protected

  def collection
    scope = end_of_association_chain
    @series_filter ||= initialize_filterrific(
        scope,
        params[:movies],
        select_options: {
        },
        ) or return
    @series ||= @series_filter.find.page(params[:page]).per(24)
  end

  private

  def series_params
    params.require(:series).permit(
        :active, :summary, :detail, category_ids: []
    )
  end

end