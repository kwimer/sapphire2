class FollowsController < ApplicationController

  inherit_resources
  respond_to :js
  belongs_to :user
  defaults singleton: true
  actions :all, except: :show

  def create
    current_user.watchlist(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/watchlists/update' }
    end
  end

  def destroy
    current_user.unwatchlist(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/watchlists/update' }
    end
  end

end