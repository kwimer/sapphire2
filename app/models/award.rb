class Award < ApplicationRecord

  belongs_to :media, polymorphic: true
  belongs_to :festival

  validates_presence_of :year

  def name
    "#{year} #{award_name} #{award_type}"
  end

end