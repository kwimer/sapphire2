class Episode < Media

  belongs_to :parent, polymorphic: true

  def should_generate_new_friendly_id?
    false
  end

end
