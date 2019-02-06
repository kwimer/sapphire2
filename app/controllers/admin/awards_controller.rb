class Admin::AwardsController < Admin::ApplicationController

  inherit_resources
  belongs_to :festival
  actions :all, :except => [ :show, :destroy ]

  def award_params
    params.require(:award).permit(
        :year, :media_id, :media_type, :award_type, :award_name
    )
  end

end
