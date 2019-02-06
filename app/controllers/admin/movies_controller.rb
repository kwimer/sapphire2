class Admin::MoviesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy, :new, :create ]

  private

  def movie_params
    params.require(:movie).permit(
        :active, :summary, :detail, category_ids: []
    )
  end

end