class Admin::ApplicationController < ActionController::Base

  layout 'admin'
  before_action :prepend_view_paths
  helper_method :page_title, :page_subtitle, :collection_title

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
    when 'new', 'create', 'edit', 'update'
      resource_class.model_name.human.pluralize
    end
  end

  def collection_title
    resource_class.model_name.human.pluralize
  end

end
