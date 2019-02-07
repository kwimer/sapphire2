class Admin::MoviesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy, :new, :create ]

  def page_subtitle
    super || 'Media'
  end

  private

  def movie_params
    params.require(:movie).permit(
        :active, :summary, :detail, category_ids: []
    )
  end

end