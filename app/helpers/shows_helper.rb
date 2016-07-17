module ShowsHelper
  def banner(url, type, name)
  	if url.nil?
  		if type == 'poster_serie'
        "http://place-hold.it/360x529&text="+name
  		elsif type == 'banner_serie'
        "http://place-hold.it/150x36&text="+name
  		elsif type == 'small_poster'
        "http://place-hold.it/262x381&text="+name
  		elsif type == 'banner_episode'
        "http://place-hold.it/400x225&text="+name+"&fontsize=20"
		  elsif type == 'new_poster'
        "http://place-hold.it/144x212&text="+name+"&fontsize=12"
		  end
  	else
  		"http://thetvdb.com/banners/#{url}"
  	end
  end
end
