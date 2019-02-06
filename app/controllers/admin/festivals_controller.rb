class Admin::FestivalsController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy ]

  def festival_params
    params.require(:festival).permit(
        :name
    )
  end

end
