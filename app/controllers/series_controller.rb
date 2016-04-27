class SeriesController < ApplicationController

    before_action :set_serie, only: [:show, :edit, :update, :destroy]

    def index
        @series = Serie.paginate(page: params[:page], per_page: 1)
    end

    def show
    end

    def new
        @serie = Serie.new
    end

    def create
        #permit : allow user to edit only name param
        @serie = Serie.new series_param
        if @serie.save
            redirect_to @serie
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @serie.update series_param
            if params[:save] == 'Enregistrer'
                redirect_to @serie
            else
                redirect_to series_path
            end
        else
            render 'edit'
        end
    end

    def destroy
        @serie.destroy
        redirect_to series_path
    end

    private 

    def series_param
        params.require(:serie).permit(
            :name,
			:overview,
			:banner,
			:poster,
			:runtime,
			:network,
			:rating,
			:status
        )
    end

    def set_serie
        @serie = Serie.find params[:id]
    end

end


