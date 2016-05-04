# app/services/api_show_service.rb
class ApiShowService
	BASE_URL = 'http://www.thetvdb.com/api'

    # def initialize(api_key, language = 'fr')
    #   	@api_key = api_key
    #   	@language = language
    # end

    def initialize()
    end

    def search(series_name)
      options = { query: {seriesname: series_name, language: 'fr'} }
      url = "#{ApiShowService::BASE_URL}/GetSeries.php"
      response = HTTParty.get(url, options)
      
      if response['Data'].blank? || response['Data']['Series'].blank?
      	 || response['Data']['Series'].blank?
          return []
      else
      	return response["Data"]['Series'].first
      end
	end
end