class Admin::ApplicationController < ActionController::Base

  layout 'admin'

  before_action :prepend_view_paths
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def authenticate_admin!
    redirect_to :root_path unless current_user.admin?
  end

  helper_method :page_title, :page_subtitle, :collection_title, :collection_name, :collection_filters

  def prepend_view_paths
    prepend_view_path "app/views/admin/application"
  end

  def page_title
    case params[:action]
    when 'index'
      parent? ? "#{parent.name} #{resource_class.model_name.human.pluralize}" : resource_class.model_name.human.pluralize
    when 'new', 'create'
      "New #{resource_class.model_name.human}"
    when 'edit', 'update'
      resource.name
    end
  end

  def page_subtitle
    case params[:action]
    when 'index'
      parent.class.model_name.human.pluralize if parent?
    when 'new', 'create', 'edit', 'update'
      resource_class.model_name.human.pluralize
    end
  end

  def collection_title
    resource_class.model_name.human.pluralize
  end

  def collection_name
    send(:resources_configuration)[:self][:collection_name]
  end

  def collection_filters
    resource_class.try(:filterrific_available_filters).try(:map, &:to_sym)
  end

end
