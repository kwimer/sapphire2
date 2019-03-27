class FollowsController < ApplicationController

  inherit_resources
  belongs_to :user
  defaults singleton: true
  actions :all, except: :show

  def create
    current_user.follow(parent)
    redirect_to parent
  end

  def destroy
    current_user.unfollow(parent)
    redirect_to parent
  end

end