atom_feed do |feed|
  feed.title("Trade Tariff - changes for #{changeable.goods_nomenclature_item_id}: #{changeable}")
  feed.updated(@changes.first.operation_date) if @changes.length > 0

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
        author.name("HM Government")
      end
    end
  end
end
