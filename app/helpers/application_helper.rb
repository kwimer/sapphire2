module ApplicationHelper

  def form_resource_path(parent = nil)
    resource.persisted? ? resource_path(resource) : collection_path(parent)
  end

  def menu_item(text, path, icon)
    content = icon_tag(icon) + content_tag(:span, text)
    active_link_to content, path, class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'
  end

  def icon_tag(icon)
    content_tag(:i, icon, class: 'material-icons')
  end

end
