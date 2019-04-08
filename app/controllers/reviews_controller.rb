class ReviewsController < ApplicationController

  inherit_resources
  respond_to :js
  belongs_to :movie, :series, polymorphic: true
  respond_to :js, only: [:create, :destroy]

  protected

  def build_resource_params
    [super.first.merge(user_id: current_user.id)]
  end

  private

  def review_params
    params.require(:review).permit(
        :rating, :content
    )
  end

end