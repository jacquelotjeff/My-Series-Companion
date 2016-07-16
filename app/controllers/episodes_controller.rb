class EpisodesController < ApplicationController
  before_action :set_params, only: [:viewed, :unviewed]

  def viewed
    @episode.users << current_user
    @episode.save
    flash[:success] = 'L\'épisode a bien été marqué comme vu.'
    
    respond_to do |format|
        format.html { redirect_to @show }
        format.json { render :show, status: :ok, location: @show }
    end
  end

  def unviewed
    user_episode = UserEpisode.find_by user: current_user, episode: @episode
    user_episode.destroy

    puts '///////////////////'
    puts 'Controlleur test de suppression'
    puts user_episode.inspect
    puts '///////////////////'

    flash[:success] = 'L\'épisode a bien été marqué comme non vu.'

    respond_to do |format|
        format.html { redirect_to @show }
        format.json { render :show, status: :ok, location: @show }
    end
  end

  private
    def set_params
      @episode = Episode.find(params[:id_episode])
      @show    = Show.find(params[:id_show])
    end

    def episode_params
      params.require(:episode).permit(:name, :number, :firstaired, :overview, :rating, :ratingcount, :season_id, :filename)
    end
end
