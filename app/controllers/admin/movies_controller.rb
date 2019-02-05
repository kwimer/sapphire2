class Admin::MoviesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :destroy ]

  def movie_params
    params.require(:movie).permit(
        :summary, :detail
    )
  end

end