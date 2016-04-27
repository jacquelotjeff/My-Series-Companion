# app/controllers/home_controller.rb

class HomeController < ApplicationController
    def index
    	@series = Serie.paginate(page: params[:page], per_page: 1)
    end
end