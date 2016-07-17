class ShowsController < ApplicationController
  require 'api_show_service'

  before_action :set_show, only: [:show, :synch, :destroy]
  before_action :authenticate_user!

  # GET /shows
  # GET /shows.json
  def index
    shows = current_user.shows
    
    if shows.empty?
      redirect_to new_show_path
    end

    if params[:shows]
      @search_value = search_params[:search]
      shows = current_user.shows.search(@search_value)
    end
    @shows = shows.order('name asc').paginate(:page => params[:page], :per_page => 7)
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
  end

  # GET /shows/new
  def new
    @user_shows = current_user.shows

    ids = @user_shows.map(&:id).join(',').split(',')

    @shows = Show.where.not(id: [ids]).order('name asc')

    puts(@shows)
    @show = Show.new
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = search_show params[:show][:name]

    #puts @show.inspect

    respond_to do |format|
      if @show.nil?
        flash[:danger] = 'Désolé, la série n\'a pas été trouvée.'
        redirect_to shows_path
        return []
      end

      if @show.save
        add_show_to_current_user @show
        format.html { redirect_to @show }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def synch
    api_show_service = ApiShowService.new()
    episodes = api_show_service.get_all_episodes(@show.idapi)

    puts '///////////////////'
    puts 'controller'
    puts episodes.inspect
    puts '///////////////////'

    update_episodes_for_show(@show, episodes)

    flash[:success] = 'Votre série a bien été mise à jour.'

    redirect_to @show
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    userShow = UserShow.find_by user: current_user, show: @show
    userShow.destroy
    
      respond_to do |format|
        flash[:success] = 'La série a bien été supprimée.'
        format.html { redirect_to shows_url }
        format.json { head :no_content }
      end
  end

  private

  def search_show(serie_name)
    api_show_service = ApiShowService.new()
    search = api_show_service.search(params[:show][:name])

    if search.any?
      exist = Show.find_by idapi: search['Series']['id']

      if exist
        show = exist
      else
        serie_infos = search['Series']
        show_informations = {
          name: serie_infos['SeriesName'],
          overview: serie_infos['Overview'],
          network: serie_infos['Network'],
          banner: serie_infos['banner'],
          poster: serie_infos['poster'],
          runtime: serie_infos['Runtime'],
          rating: serie_infos['Rating'],
          status: serie_infos['Status'],
          actors: serie_infos['Actors'],
          genre: serie_infos['Genre'],
          idapi: serie_infos['id']
        }

        show = create_show show_informations
        update_episodes_for_show(show, search['Episode'])

        return show
      end
    end
  end

  def update_episodes_for_show(show, episodes)
    episodes.each do |episode|

      season_infos = { num: episode['SeasonNumber'], show: show }
      # Check if the season exist ...
      season = Season.find_by(season_infos)

      if season.nil?
        season = Season.create(season_infos)
      end

      episode_infos = {
        name: episode['EpisodeName'],
        number: episode['EpisodeNumber'],
        firstaired: episode['FirstAired'],
        overview: episode['Overview'],
        rating: episode['Rating'],
        ratingcount: episode['RatingCount'],
        filename: episode['filename'],
        season: season
      }

      episode = Episode.find_by(episode_infos)

      if episode.nil? && !episode_infos[:name].nil?
        episode = Episode.create(episode_infos)
      end
    end
  end

  def create_show(show)
    @show = Show.create show
  end

  # Check if current user has already the show, if not add show in user shows
  def add_show_to_current_user(show)
    exist = UserShow.find_by user: current_user, show: show

    if exist.nil?
      current_user.shows << show  
      flash[:success] = 'La série a bien été ajoutée à votre liste.'
    else
      flash[:danger] = 'Cette série est déjà dans votre liste.'
    end
  end

  def set_show
    @show = Show.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:name, :overview, :banner, :poster, :runtime, :network, :rating, :status, :actors, :genre)
  end

  def search_params
    params.require(:shows).permit(:search)
  end
end
