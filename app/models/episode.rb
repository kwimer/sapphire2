class Episode < Media

  belongs_to :parent, polymorphic: true

end
