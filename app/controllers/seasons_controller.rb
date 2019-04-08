class SeasonsController < ApplicationController

  inherit_resources
  defaults finder: :find_by_number
  belongs_to :series

end
