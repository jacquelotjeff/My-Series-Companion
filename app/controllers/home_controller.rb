# app/controllers/home_controller.rb

class HomeController < ApplicationController

	before_action :authenticate_user!, only: [:shows]

    def index
    	@shows = Show.paginate(page: params[:page], per_page: 1)
    end

    def shows
    	@shows = Show.paginate(page: params[:page], per_page: 1)
    end
end