atom_feed do |feed|
  feed.tag!("meta name='robots' content='noindex, nofollow'")
  feed.title("BETA: Trade Tariff measure changes feed for #{changeable.class.model_name} #{changeable.to_param}: #{changeable}")
  feed.subtitle("BETA: This is a prototype ATOM feed showing the last 10 measure changes made to #{changeable.class.model_name} #{changeable.to_param} since #{@changes.last_change_operation_date}. Your feedback will help us to improve it.")
  feed.updated(@changes.first_change_operation_date) if @changes.any?

  @changes.each do |change|
    feed.entry(
      change,
      id: "tag:#{request.host},2005:Change/#{change.id}",
      url: change_url(anchor: change.anchor_link)
    ) do |entry|
      entry.title(change.title)
      entry.content(change.content)
      entry.updated(change.operation_date.xmlschema)

      entry.author do |author|
        author.name("UK government")
      end
    end
  end
end
