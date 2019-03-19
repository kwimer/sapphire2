class StaticController < ApplicationController
   http_basic_authenticate_with name: "igems", password: "secret"

   def search
   	@show_adv_search = true
   end
end
