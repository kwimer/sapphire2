class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :set_current_user

  protected

  def set_current_user
    RequestStore.store[:current_user_id] = current_user.id if current_user
  end

end
