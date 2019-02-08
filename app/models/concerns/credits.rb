module Credits

  extend ActiveSupport::Concern

  included do
    has_many :media_credits, as: :media
    has_many :credits, through: :media_credits
  end

end