class Admin::SeriesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :destroy ]

  def series_params
    params.require(:series).permit(
        :summary, :detail
    )
  end

end