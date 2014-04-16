module CrawlerCommons
  def should_not_include_robots_tag!
    expect(response.headers["X-Robots-Tag"]).to_not be_present
  end

  def should_include_robots_tag!
    expect(response.headers["X-Robots-Tag"]).to eq("none")
  end

  def historical_request(action, options={})
    def_options = {month: 1, year: 2008, day: 1}
    get action, def_options.merge(options)
  end
end
