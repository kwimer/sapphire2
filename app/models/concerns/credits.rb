module Credits

  extend ActiveSupport::Concern

  included do
    has_many :media_credits, as: :media
    has_many :credits, through: :media_credits
  end

  def cast_credits
    credits.includes(:person).where(credit_type: 'cast').order('media_credits.position')
  end

end