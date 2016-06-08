# app/services/api_show_service.rb
class ApiShowService
  include HTTParty
  base_uri 'http://www.thetvdb.com/api'

  def initialize()
    @api_key = Rails.application.secrets.api_access_key
  end

  def search(serie_name)
    options = { query: {seriesname: serie_name, language: 'fr'} }
    response = self.class.get("/GetSeries.php", options)
    
    puts '///////////////////'
    puts response.inspect
    puts '///////////////////'
    
    if response['Data'].blank? || response['Data']['Series'].blank?
        return []
    else
      return get_all_infos response["Data"]['Series'].first['seriesid']
    end
  end

  # Get all episodes for one serie by id
  def get_all_episodes(id_serie)
    response = self.class.get("/#{@api_key}/series/#{id_serie}/all/fr.xml")

    if response['Data'].blank? || response['Data']['Episode'].blank?
        return []
    else
      return response["Data"]['Episode']
    end
  end

  # Get All informations for one serie by id
  def get_all_infos(id_serie)
    response = self.class.get("/#{@api_key}/series/#{id_serie}/all/fr.xml")
    
    if response['Data'].blank? || response['Data']['Series'].blank?
        return []
    else
      return response["Data"]['Series']
    end
  end
end