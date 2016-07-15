class EpisodesController < ApplicationController
  before_action :set_params, only: [:viewed]

  def viewed
    if @episode.users[current_user.id].present?
      flash[:danger] = 'Il semblerait que vous ayez déjà regardé l\'épisode.'
    else
      @episode.users << current_user
      @episode.save
      flash[:success] = 'Les modifications ont bien été prises en compte.'
    end
    
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
