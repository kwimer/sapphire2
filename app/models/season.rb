class Season < ApplicationRecord

  extend Mobility
  translates :title, :summary, :tmdb_summary
  alias_attribute :name, :title

  include Credits
  include ExternalIds

  jsonb_accessor :extra_fields,
                 episodes_count: :integer

  belongs_to :series
  has_many :episodes, -> { order(:number) }

end
