module Awards

  extend ActiveSupport::Concern

  included do
    has_many :awards
  end

end