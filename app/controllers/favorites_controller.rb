class FavoritesController < ApplicationController

  inherit_resources
  respond_to :js
  belongs_to :movie, :person, :series, optional: true
  defaults singleton: true
  actions :all, except: :show

  def create
    current_user.favorite(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/favorites/update' }
    end
  end

  def destroy
    current_user.unfavorite(parent)
    parent.reload
    respond_to do |format|
      format.js { render '/favorites/update' }
    end
  end

end