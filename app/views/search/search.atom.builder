atom_feed(
  'xmlns:os' => 'http://a9.com/-/spec/opensearch/1.1/',
  root_url: perform_search_url(q: 'trade_tariff', t: @search.t)
) do |feed|
  feed.title("Trade Tariff - search results for #{@search}")
  feed.link(rel: 'search', type: 'application/opensearchdescription+xml', href: opensearch_url(format: :xml))
  feed.tag!('os:totalResults', @results.size)
  feed.tag!('os:itemsPerPage', @results.size)
  feed.tag!('os:startIndex', 1)
  feed.tag!('os:Query', role: 'request', searchTerms: @search.t)
  feed.updated(Time.now)
  feed.author do |author|
    author.name 'HM Government'
  end

  @results.all.each do |result|
    feed.entry(
      result,
      id: "tag:#{request.host},2005:#{result.class}/#{result.to_param}",
      url: polymorphic_url(result)
    ) do |entry|
      entry.title("#{result.class} #{result.to_param}")
      entry.content(result.to_s)
      entry.updated(Time.now)

      entry.author do |author|
        author.name 'HM Government'
      end
    end
  end
end
