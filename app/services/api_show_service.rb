# app/services/api_show_service.rb
class ApiShowService
	include HTTParty
	base_uri 'http://www.thetvdb.com/api'
    # def initialize(api_key, language = 'fr')
    #   	@api_key = api_key
    #   	@language = language
    # end

    def initialize()
      @api_key = Rails.application.secrets.api_access_key
    end

    def search(series_name)
      options = { query: {seriesname: series_name, language: 'fr'} }
      response = self.class.get("/GetSeries.php", options)
      
      if response['Data'].blank? || response['Data']['Series'].blank?
          return []
      else
      	return response["Data"]['Series'].first
      end
	  end

    def more_infos(series_dbtv_id)
      response = self.class.get("/" + @api_key + "/series/" + series_dbtv_id)

      if response['Data'].blank? || response['Data']['Series'].blank?
          return []
      else
        return response["Data"]['Series']
      end

    end
end