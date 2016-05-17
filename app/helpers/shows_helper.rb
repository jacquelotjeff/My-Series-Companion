module ShowsHelper
  def banner(show)
    "http://thetvdb.com/banners/#{show.banner}"
  end
  def poster(show)
    "http://thetvdb.com/banners/#{show.poster}"
  end
end
