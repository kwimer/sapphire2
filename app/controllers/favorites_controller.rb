class FavoritesController < ApplicationController

  inherit_resources
  belongs_to :movie, :series, optional: true
  defaults singleton: true
  actions :all, except: :show

  def create
    current_user.favorite(parent)
    redirect_to parent
  end

  def destroy
    current_user.unfavorite(parent)
    redirect_to parent
  end

end