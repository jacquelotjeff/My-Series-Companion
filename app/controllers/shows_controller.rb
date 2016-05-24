class ShowsController < ApplicationController
  require 'api_show_service'

  before_action :set_show, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /shows
  # GET /shows.json
  def index
      @shows = current_user.shows.order('name asc').all
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
      search_show params[:show][:name]

      respond_to do |format|
        if @show.nil?
            flash[:danger] = 'Désolé, la série n\'a pas été trouvée.'
            redirect_to shows_path
            return []
        end

        if @show.save
            add_show_current_user(@show)
            format.html { redirect_to @show }
            format.json { render :show, status: :created, location: @show }
        else
            format.html { render :new }
            format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
      respond_to do |format|
          if @show.update(show_params)
            flash[:success] = 'La série a bien été éditée.'
            format.html { redirect_to @show }
            format.json { render :show, status: :ok, location: @show }
          else
            format.html { render :edit }
            format.json { render json: @show.errors, status: :unprocessable_entity }
          end
      end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @userShow = UserShow.find_by user: current_user, show: @show
    @userShow.destroy
    
      respond_to do |format|
        flash[:success] = 'La série a bien été supprimée.'
        format.html { redirect_to shows_url }
        format.json { head :no_content }
      end
  end

  private
      def search_show serie_name
          apiShowService = ApiShowService.new()
          
          search = apiShowService.search(params[:show][:name])

          if search.any?
              
              idapi = search['seriesid']
              exist = Show.find_by idapi: idapi

              if exist
                @show = exist
              else 
                serieName     = search['SeriesName']
                serieOverview = search['Overview']
                serieNetwork  = search['Network']
                serieBanner   = search['banner']

                infos = apiShowService.more_infos(idapi)

                seriePoster  = infos['poster']
                serieRuntime = infos['Runtime']
                serieRating  = infos['Rating']
                serieStatus  = infos['Status']


                @show = Show.create name: serieName, overview: serieOverview, network: serieNetwork, banner: serieBanner, 
                                    poster: seriePoster, runtime: serieRuntime, rating: serieRating, status: serieStatus,
                                    idapi: idapi    
              end 

          end
      end  

      def add_show_current_user(show)
        if current_user
           exist = UserShow.find_by user: current_user, show: show
           if exist
            flash[:danger] = 'Cette série est déjà dans votre liste.'
           else
            current_user.shows << show  
            flash[:success] = 'La série a bien été ajoutée.'
           end
        else
           redirect_to root, notice: 'Veuillez vous connecter.'
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_show
        @show = Show.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def show_params
        params.require(:show).permit(:name, :overview, :banner, :poster, :runtime, :network, :rating, :status)
      end
end
