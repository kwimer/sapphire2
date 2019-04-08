class EpisodesController < ApplicationController

  inherit_resources
  defaults finder: :find_by_number
  belongs_to :series do
    belongs_to :season, finder: :find_by_number
  end

end