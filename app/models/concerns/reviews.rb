module Reviews

  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :record
  end

end