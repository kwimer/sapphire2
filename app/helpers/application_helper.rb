module ApplicationHelper

  def form_resource_path
    resource.persisted? ? resource_path(resource) : collection_path
  end

end
