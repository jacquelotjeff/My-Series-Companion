module ShowsHelper
  def banner(url, type)
  	if url.nil?
  		if type == 'poster_serie'
  			"http://placehold.it/360x529"
  		elsif type == 'banner_serie'
  			"http://placehold.it/150x36"
		elsif type == 'small_poster'
			"http://placehold.it/262x381"
		elsif type == 'banner_episode'
		  	"http://placehold.it/400x225"
		 elsif type == 'new_poster'
		  	"http://placehold.it/144x212"
		end
  	else
  		"http://thetvdb.com/banners/#{url}"
  	end
  end
end
