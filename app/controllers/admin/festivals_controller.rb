class Admin::FestivalsController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy ]

  def page_subtitle
    super || 'Movie'
  end

  def festival_params
    params.require(:festival).permit(
        :name
    )
  end

end
