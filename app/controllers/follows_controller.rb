class FollowsController < ApplicationController

  inherit_resources
  respond_to :js
  belongs_to :user
  defaults singleton: true
  actions :all, except: :show

  def create
    current_user.follow(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/favorites/update' }
    end
  end

  def destroy
    current_user.unfollow(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/favorites/update' }
    end
  end

end