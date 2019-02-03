class Admin::ApplicationController < ActionController::Base

  layout 'admin'
  before_action :prepend_view_paths

  def prepend_view_paths
    prepend_view_path "app/views/admin/application"
  end

end
